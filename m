From: javier.martinc@alumnos.unican.es
Subject: Re: How to start with a driver for custom hardware?
Date: Thu,  2 Oct 2008 11:02:33 +0200
Message-ID: <20081002110233.v5wregwzs4k4w48g@correo.alumnos.unican.es>
References: <20081001174336.b3mj2efijo8kcgwg@correo.alumnos.unican.es><20081
	001155221.GA15760@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ccserver2.unican.es (ccserver2.unican.es [130.206.5.101])
	by alsa0.perex.cz (Postfix) with ESMTP id A78B6244AA
	for <alsa-devel@alsa-project.org>;
	Thu,  2 Oct 2008 11:05:06 +0200 (CEST)
In-Reply-To: <20081001155221.GA15760@sirena.org.uk>
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
To: Mark Brown <broonie@sirena.org.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Respuesta a Mark Brown <broonie@sirena.org.uk>:

>> As you can see it is a simple hardware which control registers are 
>> mapped into
>> memory. Which part of the alsa driver takes care of accesing these hardware
>> dependent registers?
>
> If it were done using ASoC then you'd write ASoC platform drivers
> which would do this.

What example or documentation could I check to see how the hardware dependent
code is integrated into the platform driver?

Thanks
