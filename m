From: =?UTF-8?Q?Gonzalo_Garramu=c3=b1o?= <ggarra13@gmail.com>
Subject: Switching from default to plughw:0,0
Date: Sat, 10 Sep 2016 20:33:15 -0300
Message-ID: <0d46fa40-ea42-2103-7062-005665c7e9e1@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qk0-f180.google.com (mail-qk0-f180.google.com
 [209.85.220.180])
 by alsa0.perex.cz (Postfix) with ESMTP id 4DAB0266621
 for <alsa-devel@alsa-project.org>; Sun, 11 Sep 2016 01:33:20 +0200 (CEST)
Received: by mail-qk0-f180.google.com with SMTP id z190so101487595qkc.3
 for <alsa-devel@alsa-project.org>; Sat, 10 Sep 2016 16:33:20 -0700 (PDT)
Received: from [192.168.0.3] ([181.167.66.102])
 by smtp.gmail.com with ESMTPSA id z32sm6175418qtz.0.2016.09.10.16.33.17
 for <alsa-devel@alsa-project.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 10 Sep 2016 16:33:17 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I have coded an application that uses ALSA and plays back movie's 
audios, together with their videos.  I have pulseaudio installed by 
default as it comes with Ubuntu Xenian.

My goal is to provide the user with an easy pull-down where they can 
select the audio device to play the audio in.

The first audio device is "default" and defaults to ALSA's default in 
the Ubuntu Sound Preferences.  All that works fine.  I can change the 
Ubuntu Sound Preferences and the default driver immediately picks up the 
other cards or outputs in the system.

My problem is that when I choose the default, which is equivalent to 
plughw:0,0, when I go to force select in my program the plughw:0,0 (HDA 
Intel PCH: ALC1150 Analog), I get a Device or resource busy.

Sure enough, if I do:

$ fuser -v /dev/snd/*
                      USUARIO        ORDEN DE ACCESO PID
/dev/snd/controlC0:  gga        3594 F.... pulseaudio
/dev/snd/controlC1:  gga        3594 F.... pulseaudio
/dev/snd/pcmC0D0p:   gga        4821 F...m pulseaudio

I am very careful in closing the audio before reopening it again.  
However the resource remains busy for about 7 seconds. Then it turns into:

                    USUARIO        ORDEN DE ACCESO PID
/dev/snd/controlC0:  gga        3594 F.... pulseaudio
/dev/snd/controlC1:  gga        3594 F.... pulseaudio
/dev/snd/pcmC0D0p:   gga        4821 F...m mrViewer

and the audio works again.  My close function looks like:

   bool ALSAEngine::close()
   {

       if ( _pcm_handle )
       {
           int err = snd_pcm_drop( _pcm_handle );
           if ( err < 0 )
           {
               std::cerr << "ERROR: [alsa] snd_pcm_drop failed with "
                         << snd_strerror(err)
                         << std::endl;
           }
           err = snd_pcm_close( _pcm_handle );
           if ( err < 0 )
           {
               std::cerr << "ERROR: [alsa] snd_pcm_close failed with "
                         << snd_strerror(err)
                         << std::endl;
           }
           _pcm_handle = NULL;
       }

       return true;
   }

and the open function (simplified till it fails).


   bool ALSAEngine::open( const unsigned channels,
              const unsigned freq,
              const AudioFormat format,
              const unsigned bits )
   {

       try
       {
           close();

           int                  status;
           unsigned int         test_format = (unsigned int) format;
           char buf[256];

           /* Open the audio device */
           /* Name of device should depend on # channels in spec */
           _pcm_handle = NULL;
           status = snd_pcm_open(&_pcm_handle, device().c_str(),
                                 SND_PCM_STREAM_PLAYBACK, 0);

           if ( status < 0 || _pcm_handle == NULL ) {
               sprintf( buf, _("Couldn't open audio device %s: %s"),
                        device().c_str(), snd_strerror(status));
               THROW(buf);
           }

....snip.....

   }
