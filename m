From: "Ivica Bukvic" <ico@fuse.net>
Subject: CS4205 (snd-intel8x0) missing recording inputs
Date: Sun, 17 Nov 2002 16:05:42 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <000001c28e7d$179ce690$ab1f830a@ICO>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-user@lists.sourceforge.net, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This driver seems to be notorious right now with its features (or better
lack thereof). When using Alsa driver for the above-mentioned driver
found in many of the current laptops, not all inputs can be selected for
recording. For instance, line-in is available as an input source, but
mic-in surprisingly isn't.

One more thing is that CS4205 is a full-blown dsp so while it is
compatible with the intel8x0 standard, it in addition has some nice
features to offer, such as hw multi-open as well as SPDIF and other
gizmos. Perhaps due to such a variety of intel8x0-compatible hw that
varies in the number of features, it would be prudent to split a
intel8x0 driver into two (or more) branches, and implement these
features so that the full potential of the chip can be utilized, since
right now it seems to be utilized in a basic (sb-compatible) mode which
renders the card rather useless.

Alsa is a God-sent framework for the Linux platform, but it isn't much
good to the end-user if it runs utilizing barely-working driver. I am
aware of the fact that CS probably is not offering too much
documentation, but it seems that OSS-free drivers for the same card at
least offer some additional functionality (such as selecting mic-input)
that could be easily reimplemented in the Alsa driver. 

Personally, I'd do it myself, but I have no knowledge of Alsa
architecture, nor the driver-writing. So, for right now, I don't seem to
be to be the best person to tackle this issue. However, there have been
a number of inquiries on this list regarding this problem from both
myself and other people, but so far it has been mostly ignored.

Any thoughts, and/or suggestions regarding this issue are greatly
appreciated! Sincerely,

Ico



-------------------------------------------------------
This sf.net email is sponsored by: To learn the basics of securing 
your web site with SSL, click here to get a FREE TRIAL of a Thawte 
Server Certificate: http://www.gothawte.com/rd524.html
