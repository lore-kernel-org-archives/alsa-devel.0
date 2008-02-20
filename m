From: "Andrew Boettcher" <a.boettcher@gmail.com>
Subject: Re: Merging hg sources into kernel tree
Date: Tue, 19 Feb 2008 22:37:53 -0500
Message-ID: <6a316a6e0802191937i6f9686cereb23d83da795f461@mail.gmail.com>
References: <6a316a6e0802191818j4a02dcc8s5a2d4a687c605749@mail.gmail.com>
	<Pine.LNX.4.58.0802191854070.25872@shell4.speakeasy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.157])
	by alsa0.perex.cz (Postfix) with ESMTP id C59D2243FA
	for <alsa-devel@alsa-project.org>; Wed, 20 Feb 2008 04:37:54 +0100 (CET)
Received: by fg-out-1718.google.com with SMTP id l27so2141176fgb.44
	for <alsa-devel@alsa-project.org>; Tue, 19 Feb 2008 19:37:54 -0800 (PST)
In-Reply-To: <Pine.LNX.4.58.0802191854070.25872@shell4.speakeasy.net>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Trent Piepho <xyzzy@speakeasy.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I am trying to merge the alsa hg sources into the kernel and there is no
kernel-links target.  I took care of it manually.

On Feb 19, 2008 9:57 PM, Trent Piepho <xyzzy@speakeasy.org> wrote:

> On Tue, 19 Feb 2008, Andrew Boettcher wrote:
> > Is there a script to merge the hg sources into a kernel tree?  If not do
> I
> > need to worry about any changes other than the include/ directory?  I
> have
> > another module (cx88-alsa) that is in v4l but needs the newer alsa tree
> or I
> > get "cx88_alsa: disagrees about version of symbol xxx", so I have to
> merge
> > the sources for now.
>
> You can merge the v4l-dvb Hg sources into the kernel tree with "make
> kernel-links"
>
