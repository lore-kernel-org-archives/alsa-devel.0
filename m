From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: 24 bit sample embedded in 32 bits
Date: Mon, 02 Jul 2012 13:01:21 +0200
Message-ID: <4FF17F81.8070300@ladisch.de>
References: <4FF173D4.7060401@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 5A3E21041FE
	for <alsa-devel@alsa-project.org>;
	Mon,  2 Jul 2012 13:01:23 +0200 (CEST)
In-Reply-To: <4FF173D4.7060401@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Vipin Kumar <vipin.kumar@st.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Vipin Kumar wrote:
> I assume that the alsa framework expects the 24 bit sample data to be
> packed one after the other.

ALSA expects the sample data to conform to whatever sample format has
been configured.

Most hardware uses 32-bit sample words in memory to make the
interface to the PCI bus easier.

> I need to find a way to tell the framework that the data is 24bit
> but is embedded in 32 bit.

(HH = highest byte, LL = lowest byte, MM = middle byte)

LL MM HH     SNDRV_PCM_FORMAT_S24_3LE
xx LL MM HH  SNDRV_PCM_FORMAT_S32_LE
LL MM HH xx  SNDRV_PCM_FORMAT_S24_LE
HH MM LL     SNDRV_PCM_FORMAT_S24_3BE
HH MM LL xx  SNDRV_PCM_FORMAT_S32_BE
xx HH MM LL  SNDRV_PCM_FORMAT_S24_BE


Regards,
Clemens
