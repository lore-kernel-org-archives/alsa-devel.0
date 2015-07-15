From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: Re: [PATCH v3 9/9] ASoC: sti: Add IEC control
Date: Wed, 15 Jul 2015 11:59:46 +0200
Message-ID: <55A62F12.5000100@st.com>
References: <1434983473-25092-1-git-send-email-arnaud.pouliquen@st.com>
 <1434983473-25092-10-git-send-email-arnaud.pouliquen@st.com>
 <20150710180647.GW11162@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94]) by alsa0.perex.cz (Postfix) with ESMTP id B301E265824
 for <alsa-devel@alsa-project.org>; Wed, 15 Jul 2015 11:59:57 +0200 (CEST)
In-Reply-To: <20150710180647.GW11162@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, kernel@stlinux.com
List-Id: alsa-devel@alsa-project.org



On 07/10/2015 08:06 PM, Mark Brown wrote:
> On Mon, Jun 22, 2015 at 04:31:13PM +0200, Arnaud Pouliquen wrote:
>> Add control to configure IEC60958 settings.
>
> I had one question on the rest of the series but basically everything
> else looks reasonable - I've applied some of the earlier patches, where
> there were comments can you please send incremental fixes for them?
Incremental fix means V4 or additional patches?
> With this one there's no technical problem exactly but it seems like
> something we should have a standard userspace interface for so I'd like
> to check what's going on there and propose something standard if there
> isn't anything.  It should at most affect the control naming.
>
i not quite sure i follow you, this IEC control is not already standard?
Userland applications like Gstreamer seem already use it...
The only limitation i saw is that i did not succeed in associated 
control to PCM device, only to CPU DAI. As i will have one additional 
IEC control for HDMI, i will need to manage control index, aligned to 
CPU DAI index, but not to PCM device index.
