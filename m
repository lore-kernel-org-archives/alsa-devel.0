From: "Eliot Blennerhassett" <bigblen@icqmail.com>
Subject: Logarithmic volume controls, volume controls with -ve values
Date: Thu, 15 May 2003 20:08:12 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030515200812.9272.h006.c012.wm@mail.icqmail.com.criticalpath.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello,

the volume and level controls on my card use a logarithmic representation.

With 0.01dB steps:
Basic volume control can go from 0dB gain to -100dB
Level controls typically go from -10dBu to +22dBu
Input gain goes from -100dB to +20 dB

Mic gain from 20dB to 60dB with 20dB steps.

I have created some controls something like this:
static int snd_asihpi_level_info(snd_kcontrol_t * kcontrol, snd_ctl_elem_info_t
* uinfo)
{
	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
	uinfo->count = 2;
	uinfo->value.integer.min = -20;
	uinfo->value.integer.max = 26;
	return 0;
}

but when it comes to operating the controls using amixer or alsamixer I have
trouble, particularly when I try to set the control value to a negative number.

amixer will do it if I use a percentage, but it wont accept a negative number
(mistaking it for a command line option with a - )

alsamixer allows setting where the underlying value is +ve, and shows the
correct percentage bar, but can't set the value -ve.

Do you have any suggestions as to what I should do?

thanks

Eliot Blennerhassett
AudioScience Inc.
--
Junk footer beyond this point. Read at your own risk.


-------------------------------------------------------------
Sign up for ICQmail at http://www.icq.com/icqmail/signup.html


-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
