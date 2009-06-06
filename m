From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH] ASoc: codec tlv320aic23 fix bogus divide
	by 0 message
Date: Sat, 6 Jun 2009 09:30:30 +0100
Message-ID: <20090606083029.GA4326@sirena.org.uk>
References: <>
	<1244254558-21114-1-git-send-email-troy.kisky@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 20FF824434
	for <alsa-devel@alsa-project.org>;
	Sat,  6 Jun 2009 10:30:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1244254558-21114-1-git-send-email-troy.kisky@boundarydevices.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Troy Kisky <troy.kisky@boundarydevices.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, arunks@mistralsolutions.com
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 05, 2009 at 07:15:58PM -0700, Troy Kisky wrote:
> Some code analyzer software mistakenly gives
> divide by 0 error messages for these lines.
> This patch will end its confusion.
> 
> Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>

Applied, thanks.
