From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/4] DaVinci: DM365: Add resources for
 voice codec and platform device for VCIF
Date: Tue, 22 Sep 2009 14:39:53 -0700
Message-ID: <20090922213952.GC4736@sirena.org.uk>
References: <1253647803-32633-1-git-send-email-miguel.aguilar@ridgerun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from s-utl02-sjpop.stsn.net (s-utl02-sjpop.stsn.net [72.254.0.202])
	by alsa0.perex.cz (Postfix) with SMTP id 5E217244E4
	for <alsa-devel@alsa-project.org>;
	Tue, 22 Sep 2009 23:40:45 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1253647803-32633-1-git-send-email-miguel.aguilar@ridgerun.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: miguel.aguilar@ridgerun.com
Cc: davinci-linux-open-source@linux.davincidsp.com, clark.becker@ridgerun.com, santiago.nunez@ridgerun.com, diego.dompe@ridgerun.com, alsa-devel@alsa-project.org, nsnehaprabha@ti.com, todd.fischer@ridgerun.com
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 22, 2009 at 01:30:03PM -0600, miguel.aguilar@ridgerun.com wrote:
> From: Miguel Aguilar <miguel.aguilar@ridgerun.com>

> 1) Add the resources needed by the CQ0093 voice codec.
> 2) Add platform device for the voice codec interface.

> Signed-off-by: Miguel Aguilar <miguel.aguilar@ridgerun.com>

This looks OK for the VCIF but as I said in response to the CQ0093
driver I think that should be converted into a regular platform device.
