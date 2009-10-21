From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: question on snd_jack_report
Date: Wed, 21 Oct 2009 14:19:14 +0100
Message-ID: <20091021131913.GA15160@sirena.org.uk>
References: <98769532B4BB14429434178695419EAE6A32FA1A@bgsmsx501.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 71CBB24348
	for <alsa-devel@alsa-project.org>;
	Wed, 21 Oct 2009 15:19:15 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <98769532B4BB14429434178695419EAE6A32FA1A@bgsmsx501.gar.corp.intel.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 21, 2009 at 06:22:47PM +0530, Harsha, Priya wrote:

Please fix your MUA to wrap at 80 columns, I have once more reflowed
your text to fit.

> When I call snd_jack_report with the status of the jack, from the user
> user space which parameter should I check in the
> sys/class/input/input2 to know if the jack is present or not?

Assuming you're looking to check the presence of a device in the jack
(rather than the presence of the jack itself) then there's nothing in
sysfs, you read this information from the device node.  See evtest.c
(google should show up lots of copies) for sample code doing this.
