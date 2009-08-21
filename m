From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [patch 2/4] tlv320aic3x: Change to use device model
Date: Fri, 21 Aug 2009 10:49:23 +0100
Message-ID: <20090821094923.GA19601@rakim.wolfsonmicro.main>
References: <20090820215039.380849394@fluff.org>
	<20090820215121.748784224@fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 395AA24536
	for <alsa-devel@alsa-project.org>;
	Fri, 21 Aug 2009 11:49:27 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20090820215121.748784224@fluff.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ben Dooks <ben@simtec.co.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 20, 2009 at 10:50:41PM +0100, Ben Dooks wrote:

>  
>  struct aic3x_setup_data {
> -	int i2c_bus;
> -	unsigned short i2c_address;
>  	unsigned int gpio_func[2];
>  };

I'll apply this but it should really be refactored to make this proper
platform data for the CODEC; that can be dealt with in a future patch.
