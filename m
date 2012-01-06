From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Not able to restart audio after hibernation
Date: Fri, 6 Jan 2012 10:32:05 -0800
Message-ID: <20120106183203.GA2893@opensource.wolfsonmicro.com>
References: <4F06D156.1020208@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D09DC243B2
	for <alsa-devel@alsa-project.org>; Fri,  6 Jan 2012 19:32:26 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4F06D156.1020208@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rajeev kumar <rajeev-dlh.kumar@st.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, tiwai@suse.de, "spear--sw-devel@lists.codex.cro.st.com" <spear--sw-devel@lists.codex.cro.st.com>, Armando VISCONTI <armando.visconti@st.com>, Shiraz HASHIM <shiraz.hashim@st.com>, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 06, 2012 at 04:17:50PM +0530, Rajeev kumar wrote:

> While going through the suspend/resume implementation in the alsa
> framework, get to know that feature to support hibernation is
> missing.

Hibernation is not supported on ARM at all.  Is SPEAR not an ARM based
platform?

> Just for experiment I modified the structure and added freeze, thaw
> and restore functionality, but the result is same. The new modified
> structure looks like

This suggests that you have a bug in your suspend and resume
implementation, possibly outside of this driver.
