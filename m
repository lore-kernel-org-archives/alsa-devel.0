From: Jens Taprogge <jens.taprogge@taprogge.org>
Subject: Re: commit 7b2bfdb broke sound card detection on my
	Lenovo T400s
Date: Tue, 7 Sep 2010 20:59:29 +0200
Message-ID: <20100907185929.GA32126__23700.1822832555$1283934128$gmane$org@taprogge.org>
References: <20100906170421.GA2957@alien8.de>
	<20100906224548.GA27279@taprogge.org>
	<s5hlj7ew0ph.wl%tiwai@suse.de> <20100907090220.GA3204@alien8.de>
	<s5h7hixap1c.wl%tiwai@suse.de> <20100907094041.GA2815@alien8.de>
	<s5h1v95anxg.wl%tiwai@suse.de> <20100907095300.GB2815@alien8.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <20100907095300.GB2815@alien8.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, bp@alien8.de, linux-kernel@vger.kernel.org, alsa-devel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 07, 2010 at 11:53:00AM +0200, Frank Becker wrote:
> Takashi Iwai [2010-09-07, 11:44 +0200]:
> > At Tue, 7 Sep 2010 11:40:41 +0200,
> > Frank Becker wrote:
> > > 
> > > Takashi Iwai [2010-09-07, 11:20 +0200]:
> > > > At Tue, 7 Sep 2010 11:02:20 +0200,
> > > > Frank Becker wrote:
> > > > > 
> > > > > Takashi Iwai [2010-09-07, 08:17 +0200]:
> > > > > > At Tue, 7 Sep 2010 00:45:48 +0200,
> > > > > > Jens Taprogge wrote:
> > > > > > > 
> > > > > > > On Mon, Sep 06, 2010 at 07:04:21PM +0200, Frank Becker wrote:
> 
> Hi,
> 
> [...]
> > Oh, one forgotten question is whether your machine can have a docking
> > station.  If yes, model=thinkpad is the right choice.  If not,
> > model=ideapad would work more or less same.
> Yes[0]. With that model (T400s [1]) Lenovo introduced a new series of docking
> stations that are not backward compatible with older Lenovo/ThinkPads.
> 
> I just don't happen to have one available.
> 
> [0] http://shop.lenovo.com/SEUILibrary/controller/e/web/LenovoPortal/en_US/catalog.workflow:show-category-with-items?category-id=34851FD360E5473EB9DFEB639312E18E
> 
> [1] http://shop.lenovo.com/SEUILibrary/controller/e/web/LenovoPortal/en_US/catalog.workflow:category.details?current-catalog-id=12F0696583E04D86B9B79B0FEC01C087&current-category-id=AEA4BB4495A04C098DBEA8EBB87059AC

Hello Frank.

That is the docking station I have developed the patch with.  So
hopefully after adding your PCI IDs it should work with your Thinkpad as
well.

Best Regards
Jens

