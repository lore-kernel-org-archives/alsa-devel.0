From: "Steve DeRosier" <derosier@pianodisc.com>
Subject: RE: hw pause in USB
Date: Wed, 28 Dec 2005 15:37:44 -0800
Message-ID: <DB99F0250CDF5F438C525F4695C888DC0DA011@exchange01-srv.pianodisc.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
content-class: urn:content-classes:message
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Clemens Ladisch <ladischc@informatik.uni-halle.de>, Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Ok, still on the hw pause issue.  I've got it so the "burp" doesn't =
happen any more. But upon unpause I'm still out of sync.  At first I =
just figured that my calculations based on delay were off, but at this =
point I think I'm right.

Here's the code:

            if( device.CanPause )
            {
              snd_pcm_pause(device.pcmhandle, 1);
            }
            else
            {
              /* more complex if we can't do hardware pause. */
             =20
              /* First step: get our count */
              device.PauseFrames =3D 0;
              err =3D snd_pcm_delay( device.pcmhandle, =
&device.PauseFrames );
              if( err )
                printf( "snd_pcm_delay error: %i\n", err ); =20
                 =20
              /* Second, drop the pcm data: */
              err =3D snd_pcm_drop( device.pcmhandle );
              if( err )
                printf( "snd_pcm_drop error: %i", err ); =20
             =20
            }
       =20
            all_notes_off();
            while (device.pause.status) {
              usleep(250000);
              start_time =3D time(NULL);
              update_status();
            }
           =20
            if( device.CanPause )
            {
              snd_pcm_pause(device.pcmhandle, 0);
            }
            else
            {
              /* More difficult to do a "software pause" */
             =20
              /* Get the data from our ring buffer */
              ogg_int16_t Buff[ RingBuff_Size( device.PauseBuff ) ];
             =20
              int PauseRet =3D RingBuff_GetBuff( device.PauseBuff, Buff, =
device.PauseFrames *2 );
             =20
              if( PauseRet < device.PauseFrames*2 )
                printf( "DSP Unpause: Frames stored !=3D frames =
returned.\n" );
             =20
               err =3D snd_pcm_prepare( device.pcmhandle );
               if( err )
                 printf( "DSP Unpause: snd_pcm_prepare return error: =
%i.\n", err );
             =20
              err =3D snd_pcm_writei( device.pcmhandle, Buff, =
device.PauseFrames );
             =20
              /* since the buffer should be empty, should never overrun. =
*/
              if( (err =3D=3D -EAGAIN) )
              {
                printf( "DSP Unpause: snd_pcm_writei return -EAGAIN when =
buffer should be empty.\n" );
              }
              else if( err < 0 )
              {
                printf( "DSP Unpause: snd_pcm_writei return < 0: %i\n", =
err );
              }

Note, RingBuff_* has been tested to work and returns what I'm asking of =
it. It handles 16bit words, and since a frame (in this config anyway) is =
two 16 bit words I'm having to mult frame counts by 2 when I work with =
it.  When I do my snd_pcm_writei() calls earlier, I always then put the =
same data into the ring buffer so it is always full of the most current =
data I did via snd_pcm_writei().

Any sugestions?   =20

Thanks,
- Steve



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
