From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC v2 0/3] ASoC: Option to reorder widget power
	sequence
Date: Mon, 6 Dec 2010 22:40:08 +0000
Message-ID: <20101206224008.GA2862@opensource.wolfsonmicro.com>
References: <1291383073-16048-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2ADDC1037FF
	for <alsa-devel@alsa-project.org>; Mon,  6 Dec 2010 23:40:00 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1291383073-16048-1-git-send-email-peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 03, 2010 at 03:31:10PM +0200, Peter Ujfalusi wrote:

> Quite some time ago I have faced similar issue with the sequence of the
> DAPM register writes [1]
> For that issue, I used a workaround within the twl4030 codec driver.
> Now I have again issue with the register write sequence.

Sorry I've not got back to you yet - I want to implement the thing I was
talking about with inserting the register update into the DAPM sequence.
I think that is going to be easier and more generally useful, and it
doesn't rely on drivers knowing what's going on with the DAPM sequncing
code which is much cleaner from an abstraction point of view.
