From: Martin Bailey <martin@pcalpha.com>
Subject: Playback through softvol locks mixer
Date: Tue, 12 Jul 2011 12:13:41 -0700
Message-ID: <4E1C9CE5.4070109@pcalpha.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EXHUB018-1.exch018.msoutlookonline.net
	(exhub018-1.exch018.msoutlookonline.net [64.78.17.16])
	by alsa0.perex.cz (Postfix) with ESMTP id 6E43B244A8
	for <alsa-devel@alsa-project.org>;
	Tue, 12 Jul 2011 21:13:43 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

I setup an ALSA plugin chain to allow individual volume-controlled mono 
access to a 4-channel sound card. I'm including the asound.conf only for 
the first channel. Whenever I open "plug:playback1" and play audio, it 
appears the "playback1" softvol mixer goes locked and any attempt to 
change its value within the same or another application results in 
"Operation not permitted". Can you think of something I might be missing?

pcm.playback8k {
         type dmix
         ipc_key 666
         ipc_perm 0666
         slave {
                 pcm "hw:0"
                 format S16_LE
                 channels 4
                 rate 8000
                 buffer_size 8192
                 period_size 1024
         }
         bindings.0 0
         bindings.1 1
         bindings.2 2
         bindings.3 3
}

pcm.playback8k1 {
         type route
         slave {
                 pcm "playback8k"
                 format S16_LE
                 channels 4
         }
         ttable.0.0 1
}

pcm.playback1 {
         type softvol
         slave.pcm "playback8k1"
         control.name "playback1"
         control.card 0
         control.count 1
         min_dB -51.0
         max_dB 0.0
         resolution 256
}
ctl.playback1 {
         type hw
         card 0
}
