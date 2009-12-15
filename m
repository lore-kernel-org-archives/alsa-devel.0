From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: fsi-ak4642:
	Remove	ak4642_add_i2c_device
Date: Tue, 15 Dec 2009 00:09:16 +0000
Message-ID: <6D292CE0-15AA-4990-9042-0381EDC07570@opensource.wolfsonmicro.com>
References: <ur5qychhv.wl%morimoto.kuninori@renesas.com>
	<20091214114119.GE21066@rakim.wolfsonmicro.main>
	<uljh59k1j.wl%morimoto.kuninori@renesas.com>
	(sfid-20091215_000752_592328_D8B0034F)
Mime-Version: 1.0 (iPod Mail 7D11)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7654624439
	for <alsa-devel@alsa-project.org>; Tue, 15 Dec 2009 01:09:52 +0100 (CET)
In-Reply-To: <uljh59k1j.wl%morimoto.kuninori@renesas.com>
	(sfid-20091215_000752_592328_D8B0034F)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 15 Dec 2009, at 00:07, Kuninori Morimoto <morimoto.kuninori@renesas.com 
 > wrote:

>
> Dear Mark
>
>> It'd be better to do a single patch which updates both ASoC and MIPS
>> trees simultaneously in order to ensure that bisection continues to
>> work.  Of course, if the MIPS side has been updated separately then  
>> we
>> should just apply this code - has that happened?
>
> Ohh.. sorry. My plan was sending patch to Paul (= SuperH)
> I send this patch now.

No problem, feel free to add my ack to the combined patch.
