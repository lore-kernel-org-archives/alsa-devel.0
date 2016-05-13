From: Piotr Stankiewicz <piotrs@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 1/2] ASoC: dapm: support user-defined
 stop condition in dai_get_connected_widgets
Date: Fri, 13 May 2016 15:59:51 +0100
Message-ID: <20160513145951.GA631@localhost.localdomain>
References: <1460638999-30598-1-git-send-email-piotrs@opensource.wolfsonmicro.com>
 <20160513120905.GK22038@sirena.org.uk>
 <20160513130143.GA27465@localhost.localdomain>
 <20160513134320.GS22038@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 9EADB2606BB
 for <alsa-devel@alsa-project.org>; Fri, 13 May 2016 17:00:30 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20160513134320.GS22038@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Fri, May 13, 2016 at 02:43:20PM +0100, Mark Brown wrote:
> On Fri, May 13, 2016 at 02:01:43PM +0100, Piotr Stankiewicz wrote:
> > On Fri, May 13, 2016 at 01:09:05PM +0100, Mark Brown wrote:
> 
> > > This seems really weird and uncomfortable.  From the naming I would
> > > expect it to be a boolean function and I'm struggling to understand when
> > > it would be useful to report multiple endpoints on a widget (edge
> > > widgets normally being single objects).  The whole counting thing is
> > > mainly a combination of debugging and an artefact of the implementation.
> > > What's the motivation here?
> 
> > I don't have a strong reason for this. My motivation here was - since I
> > am adding support for stopping an arbitrary point, it could be that
> > someone would find a use in stopping the graph walk part-way through, and
> > still reporting the number of endpoints as normal. But, if that's
> > unlikely to be of use, I'm happy to make it a boolean function.
> 
> Why would the number of endpoints at the edge of the graph ever be
> something other than 0 or 1?

Now that I think about it, indeed it does not make sense. I'll respin my
pathes with custom_stop_condition returning a bool.
