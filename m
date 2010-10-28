From: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v5 1/9] davinci: EMAC support for Omapl138-Hawkboard
Date: Thu, 28 Oct 2010 19:54:01 +0400
Message-ID: <4CC99C99.5010207@mvista.com>
References: <1287511587-22216-1-git-send-email-vm.rod25@gmail.com>
	<1287511587-22216-2-git-send-email-vm.rod25@gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB593023475E6EE@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593023475E6EE-/tLxBxkBPtCIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: "Nori, Sekhar" <nsekhar-l0cyMroinI0@public.gmane.org>
Cc: "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Hello.

On 28-10-2010 18:04, Nori, Sekhar wrote:

> Sorry for jumping late on this. Some comments below:

>> From: Victor Rodriguez<victor.rodriguez-Ut8ZLSGP1ULQT0dZR+AlfA@public.gmane.org>

>> This patch adds EMAC support for the Hawkboard-L138 system

>> Signed-off-by: Victor Rodriguez<victor.rodriguez-Ut8ZLSGP1ULQT0dZR+AlfA@public.gmane.org>
>> ---
>>   arch/arm/mach-davinci/board-omapl138-hawk.c |   47 +++++++++++++++++++++++++++
>>   1 files changed, 47 insertions(+), 0 deletions(-)

>> diff --git a/arch/arm/mach-davinci/board-omapl138-hawk.c b/arch/arm/mach-davinci/board-omapl138-hawk.c
>> index c472dd8..8633245 100644
>> --- a/arch/arm/mach-davinci/board-omapl138-hawk.c
>> +++ b/arch/arm/mach-davinci/board-omapl138-hawk.c
>> @@ -19,6 +19,51 @@
>>
>>   #include<mach/cp_intc.h>
>>   #include<mach/da8xx.h>
>> +#include<mach/mux.h>
>> +
>> +#define HAWKBOARD_PHY_ID             "0:07"
>> +
>> +static short omapl138_hawk_mii_pins[] __initdata = {
>> +     DA850_MII_TXEN, DA850_MII_TXCLK, DA850_MII_COL, DA850_MII_TXD_3,
>> +     DA850_MII_TXD_2, DA850_MII_TXD_1, DA850_MII_TXD_0, DA850_MII_RXER,
>> +     DA850_MII_CRS, DA850_MII_RXCLK, DA850_MII_RXDV, DA850_MII_RXD_3,
>> +     DA850_MII_RXD_2, DA850_MII_RXD_1, DA850_MII_RXD_0, DA850_MDIO_CLK,
>> +     DA850_MDIO_D,
>> +     -1

> -1 need not be a new line. In any case, please include a ',' after it.

    Why is that? It's always a last entry in the array.

WBR, Sergei
