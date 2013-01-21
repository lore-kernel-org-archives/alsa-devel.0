From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: question on snd_soc_dai_link_event
Date: Mon, 21 Jan 2013 13:31:16 +0900
Message-ID: <20130121043115.GA4598@opensource.wolfsonmicro.com>
References: <9C1683ABA24673439FCD019782C9F4BBDA2A1C1582@SAFEX1MAIL1.st.com>
 <20121026170142.GZ18814@opensource.wolfsonmicro.com>
 <9C1683ABA24673439FCD019782C9F4BBE7D4E072A2@SAFEX1MAIL1.st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B2D872615B9
 for <alsa-devel@alsa-project.org>; Mon, 21 Jan 2013 05:37:52 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <9C1683ABA24673439FCD019782C9F4BBE7D4E072A2@SAFEX1MAIL1.st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sebastien LEDUC <sebastien.leduc@st.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "liam.r.girdwood@intel.com" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 18, 2013 at 03:07:29PM +0100, Sebastien LEDUC wrote:

Once again, don't top post.

> I am even thinking that it could be worth creating an internal PCM 
> for the  dai link that has the params field, and to call the standard
> soc functions (soc_pcm_open, ...) on it from the dai_link widget DAPM 
> callback to start / stop the PCM.

> Any feedback?

I think what's important here is that any resulting code looks sane and
works well; I'm not sure that going all the way up the stack is going to
help with that as you're more likely to expose assumptions about the
calling environment but I've not paid it much concrete attention.
