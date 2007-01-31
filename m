From: Remy Bruno <remy.bruno@trinnov.com>
Subject: RME AES32 & MADI
Date: Wed, 31 Jan 2007 13:11:48 +0100
Message-ID: <20070131121148.GA20540@trinnov.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello,

I have been working on the AES32 and will soon provide a patch to get it
(hopefully) fully operational (hdspm code).

Moreover, I also worked on the MADI card, but the original hdspm driver didn't
work for me (ie the code before my modifications to support AES32). I had to
deal with the following points:
  - it needed the DDS feature (clock divisor), as for the AES32 and hdsp9632
    cards (this may be a new behavior for recent cards)
  - the channel map needed to always be channel_map_madi_ss (and never
    channel_map_madi_ds, even at 96k), as for AES32. Otherwise, the routing was
    not correct.
  - not enough DMA memory was beeing allocated (only for
    "params_channels(params)" channels whereas it should be allocated for all
    the channels, otherwise it didn't work at 96kHz) (alsa-lib was complaining,
    so I don't think an old MADI card would work either)
  - I had to play with the channel and rate rules
    (snd_hdspm_hw_rule_channels_rate and so on) to get it working. Not
    completely clear to me how it works but it didn't work as it was

So here come my questions:
  - Was the MADI driver completely fonctionnal before now? In other words,
    maybe an older revision of the card was working as the code suggested (ie
    differently than the revision I have, which is 204), can anyone confirm
    this?
  - As a corollary: should I keep the compatibility with the old code? IE keep
    using channel_map_madi_ds, etc. for revisions < 204?

I will provide a patch when I know how to deal with the previous code.

Bye

Remy


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
