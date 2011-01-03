From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: regarding references taken on platform and codec
 driver modules
Date: Mon, 3 Jan 2011 16:35:32 +0000
Message-ID: <20110103163532.GB7370@opensource.wolfsonmicro.com>
References: <98769532B4BB14429434178695419EAE053BF51941@bgsmsx501.gar.corp.intel.com>
	<20110103155454.GE6783@opensource.wolfsonmicro.com>
	<98769532B4BB14429434178695419EAE053BF51B26@bgsmsx501.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 113702437E
	for <alsa-devel@alsa-project.org>; Mon,  3 Jan 2011 17:35:16 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <98769532B4BB14429434178695419EAE053BF51B26@bgsmsx501.gar.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Harsha, Priya" <priya.harsha@intel.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 03, 2011 at 09:57:16PM +0530, Harsha, Priya wrote:

> driver are left at 3. I did a trace back as where all the references are taken and
>  where all they are released. I find that 4 references of codec driver and 
>  platform driver are taken but only one of them is released.

> How do I fix this problem?

By understanding where the references should be taken and released then
fixing the code to do that.
