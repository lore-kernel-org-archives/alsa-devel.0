From: Adam Thomson <Adam.Thomson@diasemi.com>
Subject: Re: [PATCH v3] ASoC: codecs: Add DA732x codec driver
Date: Mon, 11 Jun 2012 09:12:22 +0100
Message-ID: <201206110813.q5B8DvXq020445@sw-eng-lt-apt-vm1>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailrelay1.diasemi.com (mailrelay1.diasemi.com [82.210.246.133])
	by alsa0.perex.cz (Postfix) with ESMTP id DF8B110415D
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Jun 2012 10:15:19 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Michal Hajduk <Michal.Hajduk@diasemi.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 11, 2012 at 05:41AM, Mark Brown wrote:
 
> This doesn't apply, please always submit new code against current
> development code for the subsystem.  You've also got something else
> wrong with your setup, the Date: header for your mail is "Date: $(date
> -R)" which is upsetting the tools.

Apologies. Was using linux-next as my base code. Will re-send changes
against your ASoC repository. Assume it should be against the 'for-next'
head?
 
> Please also send followups adding the specific devices to the ID table.

Currently there's just one device ID. Will add that now, and when new
devices are available then will then update accordingly.
