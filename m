From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Re: [alsa-cvslog] CVS: BEFORE REVERT  [SUCCESS]
	C-Media CMI9761 -A- type, TESTING 01
Date: Wed, 16 Feb 2005 17:24:36 -0500
Message-ID: <1108592676.29298.30.camel@krustophenia.net>
References: <E1D1Ttl-0000lb-In@sc8-pr-cvs1.sourceforge.net>
	 <4213BB44.5060702@gmx.de>  <4213C289.7030500@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <4213C289.7030500@gmx.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: t.schorpp@gmx.de
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 2005-02-16 at 23:00 +0100, thomas schorpp wrote:
> a) oss-apps sound on DXS slider nr 2 (xmms , /dev/mixer , dsp)
> 
> only discrete access to /dev/mixer (on/off), see if i can fix that (add 
> pcm slider again, reading diff to 2.6.0)
> 
> suggest no fixed status without reaching that.

This can't be fixed.  The softvol plugin won't work with the in-kernel
OSS emulation.

Lee



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
