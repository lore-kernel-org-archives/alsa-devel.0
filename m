From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v6] ASoC: add RT286 CODEC driver
Date: Wed, 07 May 2014 19:46:09 +0200
Message-ID: <536A7161.7090100@metafoo.de>
References: <1397455170-2701-1-git-send-email-bardliao@realtek.com>
 <20140415120428.GU12304@sirena.org.uk>
 <ABFD875FF5FB574BA706497D987D48D73AC302@RTITMBSV03.realtek.com.tw>
 <20140416211145.GC12304@sirena.org.uk>
 <ABFD875FF5FB574BA706497D987D48D73AC511@RTITMBSV03.realtek.com.tw>
 <20140418103715.GJ12304@sirena.org.uk>
 <ABFD875FF5FB574BA706497D987D48D73D68A0@RTITMBSV03.realtek.com.tw>
 <20140507172113.GI22111@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-016.synserver.de (smtp-out-029.synserver.de
 [212.40.185.29])
 by alsa0.perex.cz (Postfix) with ESMTP id 345C3265274
 for <alsa-devel@alsa-project.org>; Wed,  7 May 2014 19:46:15 +0200 (CEST)
In-Reply-To: <20140507172113.GI22111@sirena.org.uk>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Bard Liao <bardliao@realtek.com>, Gustaw Lewandowski <gustaw.lewandowski@intel.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org

On 05/07/2014 07:21 PM, Mark Brown wrote:
> On Tue, May 06, 2014 at 12:04:27PM +0000, Bard Liao wrote:
>>> -----Original Message-----
>>> From: Mark Brown [mailto:broonie@kernel.org]
>
> As I'm fairly sure has been requested before please fix your mailer to
> word wrap within paragraphs, it is very hard to read your mails since
> the lines are longer than 80 columns.
>
>> Virtual controls assume there is no related register related to the controls, so codec
>> doesn't need to set anything when the control's value is changed in general cases.
>> But rt286 need to do something when the control's value is changed especially mux
>> settings.
>
> ...
>
>> Do you have any suggestion for setting corresponding registers of a
>> virtual control?
>
> Please extend the APIs for virtual controls if you find they are missing
> things you need, they've not been widely used in this sort of context -
> I think this is the first substantial device anyone has tried to merge
> without a register map so it's likely there are gaps.

I don't think virtual controls are the right approach here. Virtual controls 
are for controls where the state is completely in software, but here the 
state is still in hardware. It's just that there is no uniform hardware map. 
But there is still some structure. So you'd have controls with custom put 
and get handlers and for DAPM widgets use the event handler.

But I still think that the best and easiest solution is to have custom 
regmap read/write function that do the translation of logical registers to 
physical read/write operations.

  - Lars
