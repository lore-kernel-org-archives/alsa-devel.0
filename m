From: Ed Sweetman <safemode@speakeasy.net>
Subject: up to date api tutorials
Date: 26 Jun 2002 13:51:23 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1025113884.26999.42.camel@psuedomode>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-zH4Lg7MwRCQfH5f7pD0+"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--=-zH4Lg7MwRCQfH5f7pD0+
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I'm not sure if the api tutorial is slightly out of date or just
completely useless due to it's complete simplicity in that the buffer is
created after you find out the period_size so you never partially fill a
period but it is for everyone else in the world who has a buffer before
they find out the period.

I'm trying to figure out why i get little clicks and blips when i really
dont think i should since i think i'm doing everything correctly. My
theory is that the period_size available is more than the size i'm
sending it even though I set the period size.

ok, my situation is this.  I have a buffer coming it that's 2KB, 16384
bits.  Parameters are set up like normal and in the tutorial for
standard pcm playback.  I set any, access, format, channels, rate_near,
period_size.   periodsize is set to 1/4 buffersize. Then i go and have a
loop that loops my writei command in another function until the stream
ends.  my writei command has a size argument of 1/4 of the buffer i'm
sending it.  now when I do this, and use it the audio playback is slow
sounding.  So i have a function that waits some time and a conditional
wrapped around the writei command to only do the write when the
available periodsize is greater than or equal to 1/4 of the buffer
size.   This allows the audio to play at normal speed but like i started
off saying, i get clicks and blips throughout the playing.  I'm not sure
what i'm not doing here.   I've attached the main portion of the code,
you can get the entire thing from
http://sourceforge.net/cvs/?group_id=51494  pull zinf ...currently mp3s
wont work at all due to their tinier buffer that gets sent to the
alsapmo but ogg vorbis files almost work.  If someone could explain
where i'm going wrong here I might be able to finish this up.  Thanks 

I'm getting desperate as it doesn't seem the 0.5x code that this is
built off of had to do anything special timing wise to work and the
tutorial examples bypass all timing problems because they make the
buffersize to the available buffersize that alsa says it has available. 


--=-zH4Lg7MwRCQfH5f7pD0+
Content-Disposition: attachment; filename=alsapmo.cpp
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-c++; name=alsapmo.cpp; charset=ANSI_X3.4-1968

/*_________________________________________________________________________=
___
       =20
        FreeAmp - The Free MP3 Player
        Driver for Advanced Linux Sound Architecture=20
              http://www.alsa-project.org
=20
        Portions Copyright (C) 1998-1999 EMusic.com

        alsapmo.cpp by Fleischer Gabor <flocsy@usa.net>
        uses code by Anders Semb Hermansen <ahermans@vf.telia.no>
        and Jaroslav Kysela <perex@jcu.cz>

        This program is free software; you can redistribute it and/or modif=
y
        it under the terms of the GNU General Public License as published b=
y
        the Free Software Foundation; either version 2 of the License, or
        (at your option) any later version.

        This program is distributed in the hope that it will be useful,
        but WITHOUT ANY WARRANTY; without even the implied warranty of
        MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
        GNU General Public License for more details.

        You should have received a copy of the GNU General Public License
        along with this program; if not, write to the Free Software
        Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
       =20
        $Id: alsapmo.cpp,v 1.4 2002/06/26 04:20:53 safemode Exp $

___________________________________________________________________________=
_*/

/* system headers */
#include <stdlib.h>
#include <iostream.h>
#include <alsa/asoundlib.h>
#include <ctype.h>
#include <errno.h>
#include <string.h>

/* project headers */
#include <config.h>
#include "alsapmo.h"
#include "facontext.h"
#include "log.h"

#define DB printf("%s:%d\n", __FILE__, __LINE__);

extern "C"
{
   PhysicalMediaOutput *Initialize(FAContext *context) {
      return new AlsaPMO(context);
   }
}

AlsaPMO::AlsaPMO(FAContext *context) :
            PhysicalMediaOutput(context)
{
   m_properlyInitialized =3D false;
   m_pBufferThread =3D NULL;

   m_iBytesPerSample =3D 0;
   m_iBaseTime =3D -1;
   m_iDataSize =3D 0;

   if (!m_pBufferThread)
   {
      m_pBufferThread =3D Thread::CreateThread();
      assert(m_pBufferThread);
      m_pBufferThread->Create(AlsaPMO::StartWorkerThread, this);
   }

   m_handle =3D NULL;
   m_device =3D NULL;
   m_channels =3D -1;
   m_samples =3D -1;
}

AlsaPMO::~AlsaPMO()=20
{
    m_bExit =3D true;
    m_pSleepSem->Signal();
    m_pPauseSem->Signal();

    if (m_pBufferThread)
    {
       m_pBufferThread->Join();
       delete m_pBufferThread;
    }

    snd_pcm_close(m_handle);
}

Error AlsaPMO::Init(OutputInfo* info)=20
{
    int                  err;
    snd_pcm_hw_params_t *params;
//    printf("init\n");
    m_properlyInitialized =3D false;

    m_iDataSize =3D info->max_buffer_size;

    err=3Dsnd_pcm_open(&m_handle, "plughw:0,0", SND_PCM_STREAM_PLAYBACK, 0)=
;=20
//                                              SND_PCM_NONBLOCK);
    if (err < 0)
    {
        ReportError("Audio device is busy. Please make sure that "
                    "another program is not using the device.");
        return (Error)pmoError_DeviceOpenFailed;
    }

    snd_output_t *errlog;
    snd_output_stdio_attach(&errlog, stderr, 0);

    // configure the device:
    m_channels=3Dinfo->number_of_channels;
    m_samples=3Dinfo->samples_per_second;
    m_samplesPerFrame=3Dinfo->samples_per_frame;

    snd_pcm_hw_params_alloca(&params);
//    printf("%d: %d\n", __LINE__, err);
    err =3D snd_pcm_hw_params_any(m_handle, params);
//    printf("%d: %d\n", __LINE__, err);
    err =3D snd_pcm_hw_params_set_access(m_handle, params,=20
                                 SND_PCM_ACCESS_RW_INTERLEAVED);
//    printf("%d: %d\n", __LINE__, m_samplesPerFrame);
    err =3D snd_pcm_hw_params_set_format(m_handle, params, SND_PCM_FORMAT_S=
16_LE);
//    printf("%d: %d\n", __LINE__, err);
    err =3D snd_pcm_hw_params_set_channels(m_handle, params, m_channels);
//    printf("%d: %d\n", __LINE__, err);
    err =3D snd_pcm_hw_params_set_rate_near(m_handle, params, m_samples, 0)=
;
//    printf("%d: %d\n", __LINE__, err);
    err =3D snd_pcm_hw_params_set_period_size(m_handle, params,m_iDataSize/=
4, 0);
    err =3D snd_pcm_hw_params_set_periods(m_handle, params, 4, 0);
//    printf("%d: %d\n", __LINE__, m_iDataSize);
//    err =3D snd_pcm_hw_params_set_periods(m_handle, params, 2, 0);=20
//    printf("%d: %d\n", __LINE__, err);
    err =3D snd_pcm_hw_params(m_handle, params);
      =20
    if (err < 0)
    {
        ReportError("Cannot initialize audio device.");
        return (Error)pmoError_DeviceOpenFailed;
    }
    snd_pcm_prepare(m_handle);
//    printf("init complete\n");

    m_properlyInitialized =3D true;
    return kError_NoErr;
}

Error AlsaPMO::Reset(bool user_stop)=20
{
//    printf("reset\n");
    if (user_stop)=20
        snd_pcm_drain(m_handle);
    else
        snd_pcm_drop(m_handle);

    snd_pcm_prepare(m_handle);

    return kError_NoErr;
}

void AlsaPMO::Pause(void)
{
//    printf("pause\n");
    m_iBaseTime =3D -1;

    PhysicalMediaOutput::Pause();
}

bool AlsaPMO::WaitForDrain(void)
{
   snd_pcm_status_t *status;

   printf("wait for drain\n");
  =20
   snd_pcm_status_alloca(&status);

   for(; !m_bExit && !m_bPause; )
   {
       snd_pcm_status(m_handle, status);
       printf("num avail: %d\n", snd_pcm_status_get_avail(status));
       if (snd_pcm_status_get_avail(status) =3D=3D=20
           snd_pcm_status_get_avail_max(status))
       {
           return true;
       }
       WasteTime();
   }

   return false;
}=20

void AlsaPMO::HandleTimeInfoEvent(PMOTimeInfoEvent *pEvent)
{
   MediaTimeInfoEvent *pmtpi;
   int32               hours, minutes, seconds;
   int                 iTotalTime =3D 0;

   return;

   if (m_iBaseTime < 0)
   {
       m_iBaseTime =3D (pEvent->GetFrameNumber() *=20
                      m_samplesPerFrame) /=20
                      m_samples;
   }
   hours =3D iTotalTime / 3600;
   minutes =3D (iTotalTime / 60) % 60;
   seconds =3D iTotalTime % 60;

   if (hours < 0  ||
       minutes < 0 || minutes > 59 ||=20
       seconds < 0 || seconds > 59)
      return;

   pmtpi =3D new MediaTimeInfoEvent(hours, minutes, seconds, 0,=20
                                  iTotalTime, 0);
   m_pTarget->AcceptEvent(pmtpi);
}

void AlsaPMO::StartWorkerThread(void *pVoidBuffer)
{
   ((AlsaPMO*)pVoidBuffer)->WorkerThread();
}

void AlsaPMO::WorkerThread(void)
{
   void                      *pBuffer;
   Error                      eErr;
   int                        iRet =3D -1;
   Event                     *pEvent;
   snd_pcm_status_t          *status;
     =20
   snd_pcm_status_alloca(&status);

   // Don't do anything until resume is called.
   m_pPauseSem->Wait();

   // Sleep for a pre buffer period
   PreBuffer();

   // The following should be abstracted out into the general thread
   // classes:
#ifdef __linux__
   struct sched_param sParam;

   sParam.sched_priority =3D sched_get_priority_max(SCHED_OTHER);
   pthread_setschedparam(pthread_self(), SCHED_OTHER, &sParam);
#endif

   for(; !m_bExit;)
   {
      if (m_bPause)
      {
          m_pPauseSem->Wait();
          continue;
      }

      // Loop until we get an Init event from the LMC
      if (!m_properlyInitialized)
      {
          pEvent =3D ((EventBuffer *)m_pInputBuffer)->GetEvent();

          if (pEvent =3D=3D NULL)
          {
              m_pLmc->Wake();
              WasteTime();

              continue;
          }

          if (pEvent->Type() =3D=3D PMO_Init)
          {
              if (IsError(Init(((PMOInitEvent *)pEvent)->GetInfo())))
              {
                  delete pEvent;
                  break;
              }
          }
          delete pEvent;

          continue;
      }

      // Set up reading a block from the buffer. If not enough bytes are
      // available, sleep for a little while and try again.
      for(;;)
      {
          eErr =3D ((EventBuffer *)m_pInputBuffer)->BeginRead(pBuffer,=20
                                                             m_iDataSize);
          if (eErr =3D=3D kError_EndOfStream || eErr =3D=3D kError_Interrup=
t)
             break;

          if (eErr =3D=3D kError_NoDataAvail)
          {
              m_pLmc->Wake();
              CheckForBufferUp();

              WasteTime();
              continue;
          }

          // Is there an event pending that we need to take care of
          // before we play this block of samples?
          if (eErr =3D=3D kError_EventPending)
          {
              pEvent =3D ((EventBuffer *)m_pInputBuffer)->PeekEvent();
                          if (pEvent =3D=3D NULL)
                                  continue;
                 =20
              if (pEvent->Type() =3D=3D PMO_Quit &&=20
                  ((EventBuffer *)m_pInputBuffer)->GetNumBytesInBuffer() > =
0)=20
              {
                  if (WaitForDrain())
                                  {
                     Reset(true);
                     m_pTarget->AcceptEvent(new Event(INFO_DoneOutputting))=
;
                     return;
                                  }
                  continue;
              }
            =20
              pEvent =3D ((EventBuffer *)m_pInputBuffer)->GetEvent();

              if (pEvent->Type() =3D=3D PMO_Init)
                  Init(((PMOInitEvent *)pEvent)->GetInfo());
   =20
              if (pEvent->Type() =3D=3D PMO_Reset)
                  Reset(false);
   =20
              if (pEvent->Type() =3D=3D PMO_Info)=20
                  HandleTimeInfoEvent((PMOTimeInfoEvent *)pEvent);
   =20
              if (pEvent->Type() =3D=3D PMO_Quit)=20
              {
                  delete pEvent;
                  m_pTarget->AcceptEvent(new Event(INFO_DoneOutputting));
                  return;
              }
=20
              delete pEvent;
   =20
              continue;
          }
         =20
          if (IsError(eErr))
          {
              ReportError("Internal error occured.");
              m_pContext->log->Error("Cannot read from buffer in PMO "
                                    "worker tread: %d\n", eErr);
              break;
          }
          break;
      }

      // Now write the block to the audio device. If the block doesn't
      // all fit, pause and loop until the entire block has been played.
      // This loop could be written using non-blocking io...
      for(;!m_bExit && !m_bPause;)
      {
	    snd_pcm_status(m_handle, status);
	    WasteTime();
	    if(snd_pcm_status_get_avail(status) >=3D m_iDataSize/4){
		ZinfVolumize((short*)pBuffer, m_iDataSize);
		iRet =3D snd_pcm_writei(m_handle, pBuffer,=20
			m_iDataSize/4);
	    }
          if (iRet =3D=3D -EAGAIN)
          {
               CheckForBufferUp();
               WasteTime();
               continue;
          }
          if (iRet =3D=3D -EIO)
          {
               snd_pcm_prepare(m_handle);
               continue;
          }
          if (iRet < 0)
          {
               printf("ret: %d\n", iRet);
	       m_pInputBuffer->EndRead(0);
               //exit(0);
          }
          break;
      }
      if (m_bExit)
      {
          m_pInputBuffer->EndRead(0);
          return;
      }

      if (m_bPause)
      {
         if (iRet =3D=3D -EAGAIN)
             m_pInputBuffer->EndRead(0);
         else
         {
             m_pInputBuffer->EndRead(iRet);
             UpdateBufferStatus();
         }
         continue;  =20
      }

      if (iRet < 0)
      {
         m_pInputBuffer->EndRead(0);
         ReportError("Could not write sound data to the soundcard.");
         m_pContext->log->Error("Failed to write to the soundcard: %s\n",=20
                               strerror(errno));
         break;
      }

      m_pInputBuffer->EndRead(iRet);
      m_pLmc->Wake();
      UpdateBufferStatus();
   }
}

--=-zH4Lg7MwRCQfH5f7pD0+--



-------------------------------------------------------
This sf.net email is sponsored by: Jabber Inc.
Don't miss the IM event of the season | Special offer for OSDN members! 
JabberConf 2002, Aug. 20-22, Keystone, CO http://www.jabberconf.com/osdn
