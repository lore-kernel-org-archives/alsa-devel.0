From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: Prague Audio miniconference - topics for
	discussion?
Date: Thu, 21 Sep 2017 09:43:34 +0100
Message-ID: <20170921084334.4tkdvysf4nfo5yip@localhost.localdomain>
References: <20170920174505.64nieg6plut36cl5@sirena.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 70E132675B1
 for <alsa-devel@alsa-project.org>; Thu, 21 Sep 2017 10:43:37 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20170920174505.64nieg6plut36cl5@sirena.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Takashi Sakamoto <o-takashi@sakamocchi.jp>
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 20, 2017 at 06:45:05PM +0100, Mark Brown wrote:
> As previously announced[1] by Takashi our annual Linux audio
> miniconference will be held this year at the SuSE offices in Prague on
> 27th October (the week of ELC-E).  Thanks again to SuSe for sponsoring
> this.  As with previous years let's pull together an agenda through a
> mailing list discussion - if people could reply to this mail with any
> topics they'd like to discuss we can take it from there.  Of course if
> we can sort things out more quickly via the mailing list that's even
> better!
> 
> I'll start things off by mentining the TLV issues that Sakamoto-san was
> raising - do we have any better ideas to handle larger binary controls
> than what's currently being done?
> 
> [1] http://mailman.alsa-project.org/pipermail/alsa-devel/2017-August/124623.html

Yeah I would second that, I have a patch chain that pulls some
bits of Sakamoto-san's previous work and updates the usage in the
ADSP driver that I was hoping to send out for comments before the
meeting. Don't think I will be able to get it out this week but
probably next week. Although that is really just tidying up the
current solution rather than looking at other alternatives.

I would also quite like to start some discussions about what
might be some sensible first steps towards Lar's plans around
rate domains.

Also I might like to have a quick discussion around ways of
handling very large register maps. Obviously, the size of the
regmaps on our CODECs are starting to annoy more than a few
maintainers and it would be good to have a quick discussion on
sensible ways to break that down and make it more managable for
review. Primarily, I have been thinking about grouping more of
the registers with the drivers that are using them and having
less of it centralised in large header files and tables within
the MFD system.

Thanks,
Charles
