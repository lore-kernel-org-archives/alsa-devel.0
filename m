From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2] ASoC: dapm - Add API call to query the
 widgets of valid DAPM paths.
Date: Fri, 22 Jul 2011 09:40:15 +0100
Message-ID: <20110722084014.GE23192@opensource.wolfsonmicro.com>
References: <1311160995-3475-1-git-send-email-lrg@ti.com>
	<20110720201524.GG26043@opensource.wolfsonmicro.com>
	<4E288376.2040500@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 29C0C243A9
	for <alsa-devel@alsa-project.org>;
	Fri, 22 Jul 2011 10:40:17 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4E288376.2040500@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 21, 2011 at 08:52:22PM +0100, Liam Girdwood wrote:
> On 20/07/11 21:15, Mark Brown wrote:

> > Hrm, this will only check the widgets connected to the first widget it
> > sees for an AIF.  For streams with multiple widgets connected (eg, left
> > and right channel) it's only going to see things on the first widget it
> > comes across which probably isn't what we were expecting.  Unless we
> > change to match the comment and query by widget name in which case we're
> > already requiring uniqueness.

> Yes, but I cant think of any single channel AIFs atm, unless Wolfson has some ?

Some of the older devices have mono voice AIFs but nothing current.  I
do think working by stream name is better.
