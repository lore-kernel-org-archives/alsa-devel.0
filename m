From: Rajeev kumar <rajeev-dlh.kumar@st.com>
Subject: Re: question application playback
Date: Wed, 4 Jan 2012 11:22:10 +0530
Message-ID: <4F03E90A.1060908@st.com>
References: <1325593416.22411.YahooMailNeo@web161301.mail.bf1.yahoo.com>
	<4F02F4FD.80802@sasken.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog103.obsmtp.com (eu1sys200aog103.obsmtp.com
	[207.126.144.115])
	by alsa0.perex.cz (Postfix) with ESMTP id 40C7D24833
	for <Alsa-devel@alsa-project.org>; Wed,  4 Jan 2012 06:52:16 +0100 (CET)
In-Reply-To: <4F02F4FD.80802@sasken.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Irfan shaikh <irfan.shaikh@sasken.com>
Cc: Ricardo Barbosa <spiderslack@yahoo.com.br>, "Alsa-devel@alsa-project.org" <Alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hello
On 1/3/2012 6:00 PM, Irfan shaikh wrote:
> Hi,
>
>          ALSA can play only raw PCM data. It is not possible to play mp3
> file directly.
> Use a decoder interface to decode the mp3 file and the send to ALSA.
>
> Regards
> Irfan
>

Please avoid top posting

> On 01/03/2012 05:53 PM, Ricardo Barbosa wrote:
>> Hi all.
>>
>>
>> I am new to development using the alsa API and follow the link code http://equalarea.com/paul/alsa-audio.html
>>
>> insert the following code.
>>
>>    FILE *fp;
>>    fp = fopen("file.mp3", "r");
>>    fclose(fp);
>>
>> and changed variable buf by the variable fp, but by running the file file.mp3 he does not play according to the way it interferes with the function snd_pcm_writei ? someone could help me in developing this playback, I thank
>>

AFAIK, ALSA can play mp3 files.

>> Regards.
>> _______________________________________________
>> Alsa-devel mailing list
>> Alsa-devel@alsa-project.org
>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>>
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
