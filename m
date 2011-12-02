From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: Exporting playback and capture capability to user
 space
Date: Fri, 02 Dec 2011 17:20:39 +0530
Message-ID: <1322826639.1516.1015.camel@vkoul-udesk3>
References: <4E65E934.2070706@st.com>
	<20110906180138.GC2924@opensource.wolfsonmicro.com>
	<4E66EFC3.2070706@st.com> <4EC50DB2.6090009@st.com>
	<4EC9E656.1050706@st.com> <1321856626.1516.208.camel@vkoul-udesk3>
	<4ECB24C7.4080908@st.com>  <4ED8AD60.6060000@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id A5BAE24152
	for <alsa-devel@alsa-project.org>; Fri,  2 Dec 2011 12:52:50 +0100 (CET)
In-Reply-To: <4ED8AD60.6060000@st.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, 2011-12-02 at 16:20 +0530, Rajeev kumar wrote:
> > cpu dai: In case of cpu dai, we are passing the playback and capture
> > capability from the platform code and depending on the capability we
> are
> > filling the cpu dai structure in probe function, like
Unless we find what is being passed, its hard to comment.

As I said previously this will happen when you are reporting cpu dai
wrongly, so  hack there to fix your issue

-- 
~Vinod
