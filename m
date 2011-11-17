From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Exporting playback and capture capability to user
	space
Date: Thu, 17 Nov 2011 15:19:13 +0000
Message-ID: <20111117151912.GD19918@opensource.wolfsonmicro.com>
References: <4E65E934.2070706@st.com>
	<20110906180138.GC2924@opensource.wolfsonmicro.com>
	<4E66EFC3.2070706@st.com> <4EC50DB2.6090009@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A52B9103A84
	for <alsa-devel@alsa-project.org>; Thu, 17 Nov 2011 16:19:16 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4EC50DB2.6090009@st.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 17, 2011 at 07:05:46PM +0530, Rajeev kumar wrote:

> In command 'aplay -l' or 'cat /proc/asound/pcm', among playback
> devices, capture device is also listed.  This is true in case-1 but

This is the intended behaviour, capture only PCMs are still PCMs.
