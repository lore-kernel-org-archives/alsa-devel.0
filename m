From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Triggering a DAPM widget event
Date: Thu, 27 Jan 2011 09:56:20 +0000
Message-ID: <20110127095620.GB1338@opensource.wolfsonmicro.com>
References: <20110126182754.GJ8501@opensource.wolfsonmicro.com>
	<39D4D143FC30524CAB784A72ADFECEEE34A0E8F455@NLCLUEXM02.connect1.local>
	<4D411A33.3080205@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4A2F7103AB1
	for <alsa-devel@alsa-project.org>; Thu, 27 Jan 2011 11:23:06 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4D411A33.3080205@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: "ext Harrod, John" <john.harrod@philips.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 27, 2011 at 09:09:39AM +0200, Peter Ujfalusi wrote:

> If you stop, and restart the playback stream within 5 sec, events will
> not be triggered on the widgets, since they are still powered.

It's worth remembering (mostly for the original poster, I know you're
aware of this) that all this is completely invisible to applications.
Applications should just say what they're using at any given time, the
kernel will then power off as much as it can.
