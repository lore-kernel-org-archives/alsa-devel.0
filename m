From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [alsa-devel] [FFADO-devel] [RFC][PATCH 00/13] alsa-tools:
	libhinawa for control applications of FireWire devices
Date: Fri, 20 Mar 2015 11:09:59 +0100
Message-ID: <550BF1F7.7010801@ladisch.de>
References: <1422185674-16431-1-git-send-email-o-takashi@sakamocchi.jp>
	<550BE82A.7090901@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <550BE82A.7090901@gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: Damien Zammit <damien.zammit@gmail.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, perex@perex.cz, ffado-devel@lists.sf.net, linux1394-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Damien Zammit wrote:
> Why can't we just use the proven alsa-mixer control system for all this?

This does not prevent implementing ALSA userspace controls, which are
stored and accessed like 'real' hardware controls.


Regards,
Clemens

------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
