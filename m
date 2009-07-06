From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] ASoC: DaVinci: Change default output
	volume
Date: Mon, 6 Jul 2009 23:07:44 +0100
Message-ID: <20090706220743.GE25548@sirena.org.uk>
References: <1246917723-27071-1-git-send-email-khilman@deeprootsystems.com>
	<1246917723-27071-2-git-send-email-khilman@deeprootsystems.com>
	<1246917723-27071-3-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 7363F24542
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Jul 2009 00:07:50 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1246917723-27071-3-git-send-email-khilman@deeprootsystems.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: alsa-devel@alsa-project.org, davinci-linux-open-source@linux.davincidsp.com, Naresh Medisetty <naresh@ti.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 06, 2009 at 03:02:03PM -0700, Kevin Hilman wrote:
> From: Naresh Medisetty <naresh@ti.com>

> Changes default output volume of alsa driver since it is very low

> Signed-off-by: Naresh Medisetty <naresh@ti.com>
> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>

Nack.  The setup of the audio routing should be handled by user space on
the system - the default setup is generally taken from hardware.  Most
of the ASoC CODECs are flexible enough to make choosing a default which
makes sense to all systems pretty much impossible, and even within
systems many have sufficient options to mean that something needs to be
worked out dynamically at runtime rather than hard coded into the kernel.

Naresh, changes like this which are not specific to the architecture
should be submmitted directly to the subsystems.
