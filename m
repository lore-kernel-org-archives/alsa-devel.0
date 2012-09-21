From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Linux Kernel-3.5 crashed as dapm is not supported
	by codec
Date: Fri, 21 Sep 2012 07:14:56 -0400
Message-ID: <20120921111455.GB21524@opensource.wolfsonmicro.com>
References: <505AFB0B.7010306@st.com>
 <20120920114951.GJ17666@opensource.wolfsonmicro.com>
 <505BE5BB.5010008@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4A1BD2615CA
 for <alsa-devel@alsa-project.org>; Fri, 21 Sep 2012 13:14:59 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <505BE5BB.5010008@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rajeev kumar <rajeev-dlh.kumar@st.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 21, 2012 at 09:27:47AM +0530, Rajeev kumar wrote:
> On 9/20/2012 5:19 PM, Mark Brown wrote:

> >DAPM is mandatory now, though any device with an audio interface
> >connected should have some DAPM widgets added transparently so its not
> >always explicitly present in the CODEC driver.  It's just causing too
> >much pain to special case non-DAPM devices and theres really not any
> >cases where there's no need for widgets.

> Is DAPM operates on event? In my device event generation is not
> there.Please correct me if I am wrong.

I can't parse the above, sorry.  Please clarify your question.

> Are there some dummy interface for DAPM? What are those interfaces?

No, DAPM is just there.
