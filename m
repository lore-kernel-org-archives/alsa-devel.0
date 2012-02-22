From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: How to trigger a widget?
Date: Wed, 22 Feb 2012 09:28:01 +0200
Message-ID: <4F449901.302@ti.com>
References: <D618B7A80E26984A9E4E1FD204983C1AA88700@nasanexd01d.na.qualcomm.com>
	<4F420D6D.4050500@metafoo.de>
	<D618B7A80E26984A9E4E1FD204983C1AA8AAF4@nasanexd01d.na.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog121.obsmtp.com (na3sys009aog121.obsmtp.com
	[74.125.149.145])
	by alsa0.perex.cz (Postfix) with ESMTP id 51B122454E
	for <alsa-devel@alsa-project.org>; Wed, 22 Feb 2012 08:27:57 +0100 (CET)
Received: by lahc1 with SMTP id c1so9176168lah.20
	for <alsa-devel@alsa-project.org>; Tue, 21 Feb 2012 23:27:54 -0800 (PST)
In-Reply-To: <D618B7A80E26984A9E4E1FD204983C1AA8AAF4@nasanexd01d.na.qualcomm.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Wang, Kuirong" <kuirongw@quicinc.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Hi,

On 02/21/2012 07:09 AM, Wang, Kuirong wrote:
> I have kcontrol to enable a function of codec on fly.  With or
> without the function, it cannot impact the established audio routing.
> So I created widget as a supply, as long as the audio path is
> established, this supply widget is triggered. The supply widget has a
> callback event function.  The kcontrol control has an event callback
> function as well which calls the enable/disable pin to trigger the
> widget callback event, so this particular function can be enabled or
> disabled.

Would not it be simpler if you just enable/disable the feature in the
kcontrol's set callback?

Another way I would go is this:

                  |-> (off) ---------|
[Feature switch] -|                  |-> [next widget]
                  |-> (on) -> [PGA] -|

In the PGA you turn on/off the feature. If the switch changes it will
not affect other items in the path, it will only make the PGA to turn
on/off.

-- =

P=E9ter
