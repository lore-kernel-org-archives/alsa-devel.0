From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: question application playback
Date: Wed, 04 Jan 2012 19:03:03 +0530
Message-ID: <1325683983.1540.68.camel@vkoul-udesk3>
References: <1325593416.22411.YahooMailNeo@web161301.mail.bf1.yahoo.com>
	<4F02F4FD.80802@sasken.com>  <4F03E90A.1060908@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 96C5F103A72
	for <Alsa-devel@alsa-project.org>; Wed,  4 Jan 2012 14:32:50 +0100 (CET)
In-Reply-To: <4F03E90A.1060908@st.com>
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
Cc: Ricardo Barbosa <spiderslack@yahoo.com.br>, Irfan shaikh <irfan.shaikh@sasken.com>, "Alsa-devel@alsa-project.org" <Alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 2012-01-04 at 11:22 +0530, Rajeev kumar wrote:
> > On 01/03/2012 05:53 PM, Ricardo Barbosa wrote:
> >> Hi all.
> >>
> >>
> >> I am new to development using the alsa API and follow the link code
> http://equalarea.com/paul/alsa-audio.html
> >>
> >> insert the following code.
> >>
> >>    FILE *fp;
> >>    fp = fopen("file.mp3", "r");
> >>    fclose(fp);
> >>
> >> and changed variable buf by the variable fp, but by running the
> file file.mp3 he does not play according to the way it interferes with
> the function snd_pcm_writei ? someone could help me in developing this
> playback, I thank
> >>
> 
> AFAIK, ALSA can play mp3 files.
really??? not the pcm interface.....

-- 
~Vinod
