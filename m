From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH]: ARM DaVinci ASoC: Fix module unload error
Date: Fri, 13 Feb 2009 13:30:57 +0000
Message-ID: <20090213133057.GC31085@sirena.org.uk>
References: <1234508979-13522-1-git-send-email-chaithrika@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 7EBDE243BE
	for <alsa-devel@alsa-project.org>; Fri, 13 Feb 2009 14:30:58 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1234508979-13522-1-git-send-email-chaithrika@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: chaithrika@ti.com
Cc: alsa-devel@alsa-project.org, davinci-linux-open-source@linux.davincidsp.com
List-Id: alsa-devel@alsa-project.org

On Fri, Feb 13, 2009 at 12:39:39PM +0530, chaithrika@ti.com wrote:
> From: Chaithrika U S <chaithrika@ti.com>

> Fix for the error when the audio module is unloaded.
> On unregistering the platform_device, platform_device_release will free the 
> platform data.If platform data is static the kernel panics when it is freed.
> Instead use the platform device helper function to add data.

Which kernel tree is this patch against?  It doesn't apply against
either the topic/asoc or fix/asoc branch of

	git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git
