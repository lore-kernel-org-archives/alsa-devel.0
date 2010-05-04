From: Kai Vehmanen <kvehmanen@eca.cx>
Subject: Re: timestamps
Date: Tue, 4 May 2010 21:22:16 +0300 (EEST)
Message-ID: <alpine.DEB.1.10.1005042109290.3327@ecabase.localdomain>
References: <4BCEDADE.4010000@axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gw02.mail.saunalahti.fi (gw02.mail.saunalahti.fi
	[195.197.172.116])
	by alsa0.perex.cz (Postfix) with ESMTP id 0C7E2243FE
	for <alsa-devel@alsa-project.org>;
	Tue,  4 May 2010 20:24:37 +0200 (CEST)
In-Reply-To: <4BCEDADE.4010000@axis.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jonas Holmberg <jonas.holmberg@axis.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

On Wed, 21 Apr 2010, Jonas Holmberg wrote:

> How can I get the CLOCK_MONOTONIC timestamp for the first sample in the
> data I get from snd_pcm_readi()?

before reading the data, take the current timestamp (with clock_gettime) 
and subtract snd_pcm_delay() for the stream (see the API docs for 
snd_pcm_delay() for more details).

The accuracy of the returned value depends on the driver/hw's ability to 
report accurate delay values.

PS Alternate strategy is to use SND_PCM_TSTAMP_MMAP mode, in which
    you can query (with snd_pcm_htimestamp()) the timestamp of
    last period elapsed event. See the alsa-lib PCM API docs for
    details. With certain drivers/hw, this is the only way to get
    accurate estimates for delay.
