From: Petr Gladkikh <batyi@mail.ru>
Subject: Re: Notes on 1.0.8-rc1 (and post-rc1)
Date: Wed, 12 Jan 2005 11:51:14 +0600
Message-ID: <41E4BAD2.3080106@mail.ru>
References: <s5hfz1rd592.wl@alsa2.suse.de>
Reply-To: batyi@mail.ru
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hfz1rd592.wl@alsa2.suse.de>
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
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello.

Takashi Iwai wrote:
 > - Experimental softvol PCM plugin
 > The last one may need a bit more explanation.
 > This plugin is for the boards equipped with codecs which have no
 > volume controls (e.g. some c-media codecs).  The plugin can add a
 > new user-defined control and apply the volume attenuation.
 >
 > The typical usage is like below:
 >
 > pcm.svol {
 > 	type softvol
 > 	slave.pcm hw:0
 > 	control {
 > 		name "PCM Playback Volume"
 > 	}
 > }
 >
 > After you put this to ~/.asoundrc, run "aplay -Dsvol foo.wav".
 > Then the PCM volume is created (if not exists yet).
 > Note that the volume element will appear first after you run this
 > softvol PCM.  Don't forget to raise the volume.

A while back ago I had written a message about this and thought it was 
plainly ignored :) And so I dared to write some code myself and 
already have working implementation (with exception of control 
emulation itself).

Here is description of what I've made:

1. Volume pcm which have volume coefficient as a parameter.
2. Mixer hook which can push volume coefficient from specified mixer 
control element into given value (It does it in a way similar to 
watching control changes in alsamixer). This hook can be attached to 
volume pcm.

Configuration example

pcm.vol {
	type volume
	slave.pcm hw:0
	coeff 0.9
	hook {
		card default
		control Master
		index 0
	}
}

Explicitly specified coefficient and one provided by hook are 
multiplied before applying to samples. Input and output PCM formats 
must match (as for copy plugin).

These things are usable alone. For example you can adjust amplitude of 
PCM or tell Master_volume_control of one card to affect output of 
another :) But to completely cheat applications all this lacks some 
emulated volume control like described in quoted post above.

So I wonder if this code could be useful for alsa-lib? Perhaps it can 
  supplement softvol code? I would like it to be reviewed by anyone 
who interested. (I'll send the path in few days.)

/Petr.


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
