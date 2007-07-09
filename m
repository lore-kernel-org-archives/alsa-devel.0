From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: Re: Question about write asoc driver
Date: Mon, 09 Jul 2007 12:01:50 +0100
Message-ID: <1183978910.11330.180.camel@localhost.localdomain>
References: <afe668f90707090150q28f6c837l69980dfaba3afe33@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (unknown [80.75.67.54])
	by alsa0.perex.cz (Postfix) with ESMTP id 92578103877
	for <alsa-devel@alsa-project.org>;
	Mon,  9 Jul 2007 13:01:51 +0200 (CEST)
In-Reply-To: <afe668f90707090150q28f6c837l69980dfaba3afe33@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Roy Huang <royhuang9@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 2007-07-09 at 16:50 +0800, Roy Huang wrote:
> Hi guys,
> 
> I am write a codec driver under asoc frame work for ad1980 by study
> the sample driver wm9712.c. I find there are some control item likes
> "out3 switch" to control 16h:15. There are also some widget item likes
> "out 3 PGA" to control 24:5. How can I determine a register bit should
> be a control item or widget item? Thanks ahead.
> 

A widget describes a power block within the audio subsystem (this
includes the codec and machine). Widgets usually have several kcontrols
that control their power state and map to hardware audio components like
mixers, amps, DAC'c, ADC's, etc (anything that draws power). A widget is
"on" when there is a valid signal path routing from it's source to sink.

Widgets are entirely optional under ASoC and are only used by DAPM when
making power management decisions. I'd recommend adding them in only for
low power codecs and after you have audio working in the codec driver
(easier to debug).

A general rule for deciding whether something is a widget :-

 * Is a widget if it control audio signal routing (e.g. mixer, mux,
jack)
 * Is a codec/machine audio sink or source (pin, DAC, ADC)

HTH

Liam     
