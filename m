From: Jimen Ching <jching@flex.com>
Subject: Separating left/right channels (voices)
Date: Sat, 6 Apr 2002 13:37:52 -1000 (HST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020406132739.U83199-100000@flex.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi all,

I am working on a problem where I want to extract the left and right
channels from a sound file.  I am running into a problem where I can not
tell if the samples are from the left only, or the right only channels.
I have a sound file that is mono, when I play this file through ALSA, the
samples come out on both left and right speakers.  It seems either ALSA is
sending the mono samples to both channels, or my soundcard is doing it.
I am wondering if there is a way to control whether a mono sound file can
be played to only one speaker using ALSA.

Also, does anyone have a sound file that has one song on the left channel
and another song on the right channel?  Does anyone know how to generate
such a file from two mono files?

Any help is greatly appreciated.

--jc

P.S.  I might be confusing the terms 'channels' and 'voices'.  I know some
people and tools use them differently.  Basically, I am using the term
'channels' to mean the left and right parts of a file with stereo samples.

--
Jimen Ching (WH6BRR)      jching@flex.com     wh6brr@uhm.ampr.org
