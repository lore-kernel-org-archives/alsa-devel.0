From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [query] codec suspend not called when bias level
 is SND_SOC_BIAS_ON
Date: Wed, 5 Dec 2012 18:27:40 +0900
Message-ID: <20121205092739.GC4825@opensource.wolfsonmicro.com>
References: <20121205070856.GA1017@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DFD052608E7
 for <alsa-devel@alsa-project.org>; Wed,  5 Dec 2012 10:27:47 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20121205070856.GA1017@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shiraz Hashim <shiraz.hashim@st.com>
Cc: viresh.kumar@linaro.org, Linux-ALSA <alsa-devel@alsa-project.org>, spear-devel@list.st.com
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 05, 2012 at 12:38:56PM +0530, Shiraz Hashim wrote:

> My question is, during on-going audio play when system is put into
> suspend, codec->driver->suspend would not be called as its bias level
> is still SND_SOC_BIAS_ON, thus not giving a chance to codec to save
> its state.

> Is my understanding correct ? How to deal with this ?

Playback will be stopped as part of the DAPM teardown if it's supposed
to be stopped, this is for cases where bypass paths are still active due
to being marked as ignoring suspend.
