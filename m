From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: HDA driver without interrupt
Date: Wed, 02 May 2012 14:28:15 -0500
Message-ID: <4FA18ACF.7020106@linux.intel.com>
References: <4FA12E91.8050804@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by alsa0.perex.cz (Postfix) with ESMTP id A58F324345
	for <alsa-devel@alsa-project.org>;
	Wed,  2 May 2012 21:28:17 +0200 (CEST)
In-Reply-To: <4FA12E91.8050804@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 5/2/2012 7:54 AM, liufc wrote:
> Hi guys,I'm trying to implement an alsa driver based on the Intel HDA
> driver.However due to some hardware defects,I'm not able to use
> interrupt.So I wonder whether there is a way to do the job without the
> help of interrupt.Can anyone give me a suggestion?
What interrupt are you talking about? ALSA has the ability to discard 
periodic interrupts but the user-space code needs to explicitly request 
this mode (eg PulseAudio/AudioHAL). Regular/legacy apps do need an 
interrupt coming from the hardware.
-Pierre
