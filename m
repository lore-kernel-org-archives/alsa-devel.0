From: Victor Rodriguez <vm.rod25-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v5 1/9] davinci: EMAC support for Omapl138-Hawkboard
Date: Thu, 28 Oct 2010 11:20:55 -0500
Message-ID: <AANLkTikn7-=TM=KSrK-QXTE1sTyjKhfOyhZKY3g7rFtu@mail.gmail.com>
References: <1287511587-22216-1-git-send-email-vm.rod25@gmail.com>
	<1287511587-22216-2-git-send-email-vm.rod25@gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB593023475E6EE@dbde02.ent.ti.com>
	<B85A65D85D7EB246BE421B3FB0FBB593023475E702@dbde02.ent.ti.com>
	<AANLkTi=NNVieBNmSAfuebZQGAFMxXkpirZXeRSHLb2OA@mail.gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB593023475E71A@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593023475E71A-/tLxBxkBPtCIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
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
Cc: "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, "sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org" <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 28, 2010 at 9:34 AM, Nori, Sekhar <nsekhar-l0cyMroinI0@public.gmane.org> wrote:
> On Thu, Oct 28, 2010 at 19:51:28, Victor Rodriguez wrote:
>
>> Ok so let me see if I understand The only change that I should do is to =
remove
>>
>> > + =A0 =A0 if (!machine_is_omapl138_hawkboard())
>> > + =A0 =A0 =A0 =A0 =A0 =A0 return;
>>
>> right ?
>>
>
> Yes.
>
> Thanks,
> Sekhar
>
>

The change is ready and running but I have  a question if the new
patch apply fine and any other patches of the series has been changed
should i send all the patches again like patchv6 ? or should i send
this EMAC patch like resend patch ?

I do not thick so but if it is necessary I will do it


Thanks and regards

Victor Rodriguez
