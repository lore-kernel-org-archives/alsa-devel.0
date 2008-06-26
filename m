From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [asoc-dev][RFC/PATCH 0/2] Generic DAPM register
 modifier widget
Date: Thu, 26 Jun 2008 13:11:36 +0300
Message-ID: <20080626131136.ea03437e.jarkko.nikula@nokia.com>
References: <1214394128-7062-1-git-send-email-jarkko.nikula@nokia.com>
	<1214395280.3877.61.camel@localhost.localdomain>
	<20080625151555.81154289.jarkko.nikula@nokia.com>
	<1214408433.3877.103.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id BC594245CD
	for <alsa-devel@alsa-project.org>;
	Thu, 26 Jun 2008 12:11:35 +0200 (CEST)
In-Reply-To: <1214408433.3877.103.camel@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Liam Girdwood <lg@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 25 Jun 2008 16:40:33 +0100
"ext Liam Girdwood" <lg@opensource.wolfsonmicro.com> wrote:

> > > Any chance you could also add a little text to
> > > Docs/sound/alsa/soc/dapm.txt for this.
> > > 
> > Documentation? That's difficult and actually forgot it completely :-)
> > 
> > But is it documented already? "There are convience macros defined in
> > soc-dapm.h that can be used to quickly build a list of widgets of the
> > codecs and machines DAPM widgets."
> > 
> 
> Sorry, just to clarify, I was meaning 1 line in section 2 of dapm.txt
> (the widget type table). Just a little description next to the others.
> 
A diff like below looks bit confusing since the patch itself doesn't
add anything new into enum snd_soc_dapm_type. What would you think?


Jarkko

diff --git a/Documentation/sound/alsa/soc/dapm.txt b/Documentation/sound/alsa/soc/dapm.txt
index c784a18..d621b50 100644
--- a/Documentation/sound/alsa/soc/dapm.txt
+++ b/Documentation/sound/alsa/soc/dapm.txt
@@ -64,6 +64,7 @@ Audio DAPM widgets fall into a number of types:-
  o Speaker    - Speaker
  o Pre        - Special PRE widget (exec before all others)
  o Post       - Special POST widget (exec after all others)
+ o Generic    - Generic register modifier widget which can have any type above
 
 (Widgets are defined in include/sound/soc-dapm.h)
