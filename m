From: Thomas Hood <jdthood@yahoo.co.uk>
Subject: Re: Best default values for "External Amplifier" and
 "Audigy Analog/Digital Output Jack"
Date: Mon, 19 Sep 2005 14:46:41 +0200
Message-ID: <432EB331.2010600@yahoo.co.uk>
References: <432D290E.4010506@yahoo.co.uk> <432D5312.1000506@superbug.co.uk> <m21x3lutb7.fsf@vador.mandriva.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <m21x3lutb7.fsf@vador.mandriva.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Thierry Vignaud <tvignaud@mandriva.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Thierry Vignaud wrote:
> i second that.

Here are the controls that are (currently) set in the ALSA initscript
in Debian.  I would appreciate it if you could give me a similar list
of controls that are set by Mandriva.

from /etc/init.d/alsa-utils:

        unmute_and_set_level "Master" "80%"
        unmute_and_set_level "Master Digital" "80%"   # E.g., cs4237B
        unmute_and_set_level "Playback" "80%"
        unmute_and_set_level "Headphone" "70%"
        unmute_and_set_level "PCM" "80%"
        unmute_and_set_level "PCM,1" "80%"   # E.g., ess1969
        unmute_and_set_level "DAC" "80%"     # E.g., envy24, cs46xx
        unmute_and_set_level "DAC,0" "80%"   # E.g., envy24
        unmute_and_set_level "DAC,1" "80%"   # E.g., envy24
        unmute_and_set_level "Synth" "80%"
        unmute_and_set_level "CD" "80%"

        mute_and_zero_level "Mic"

        # Intel P4P800-MX  (Ubuntu bug #5813)
        switch_control "Master Playback Switch" on

        # Trident/YMFPCI/emu10k1:
        unmute_and_set_level "Wave" "80%"
        unmute_and_set_level "Music" "80%"
        unmute_and_set_level "AC97" "80%"

        # DRC:
        unmute_and_set_level "Dynamic Range Compression" "80%"

        # Required at least for Via 823x hardware on DFI K8M800-MLVF
        switch_control "IEC958 Capture Monitor" off

        # Required on some notebooks with ICH4:
        switch_control "Headphone Jack Sense" off
        switch_control "Line Jack Sense" off

-- 
Thomas Hood


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
