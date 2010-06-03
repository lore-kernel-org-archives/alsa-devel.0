From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC: Defining "signed integer" mixer controls?
Date: Thu, 3 Jun 2010 12:21:12 +0100
Message-ID: <20100603112110.GB24589@sirena.org.uk>
References: <hu6v9i$v43$1@dough.gmane.org>
	<AANLkTinxNwLVdaB9yR508esg-gwQJv2bMHkrUqhtVYwe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id F1A40243ED
	for <alsa-devel@alsa-project.org>;
	Thu,  3 Jun 2010 13:32:57 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AANLkTinxNwLVdaB9yR508esg-gwQJv2bMHkrUqhtVYwe@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: James Courtier-Dutton <james.dutton@gmail.com>
Cc: alsa-devel@alsa-project.org, Stuart Longland <redhatter@gentoo.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 03, 2010 at 08:09:36AM +0100, James Courtier-Dutton wrote:

> ALSA is not set up to convert bitfields to dB values.

ASoC (which is what he's actually using here) is - most controls are
defined as bitfields in the register map.
