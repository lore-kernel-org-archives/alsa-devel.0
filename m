From: Pavel Hofman <pavel.hofman@insite.cz>
Subject: Re: [PATCH] PCM parameters in file plugin
Date: Mon, 26 Jan 2009 15:28:51 +0100
Message-ID: <497DC8A3.4060706@insite.cz>
References: <49627395.1090506@insite.cz>	<49632995.9000109@insite.cz>	<Pine.LNX.4.61.0901061128300.8273@tm8103.perex-int.cz>	<49634196.1070500@insite.cz>
	<4974FCC1.70907@insite.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server.insite.cz (cable.insite.cz [84.242.84.93])
	by alsa0.perex.cz (Postfix) with ESMTP id 8E3E92438D
	for <alsa-devel@alsa-project.org>; Mon, 26 Jan 2009 15:28:51 +0100 (CET)
In-Reply-To: <4974FCC1.70907@insite.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Pavel Hofman wrote:
> Pavel Hofman wrote:
>> Jaroslav Kysela wrote:
>>> On Tue, 6 Jan 2009, Pavel Hofman wrote:
>>>
>>>> Pavel Hofman napsal(a):
>>>>> Hello,
>>>>>
>>>>> I am working on a file plugin patch to allow adding PCM parameters 
>>>>> (rate, format) to  the name of the file created (plus the ability 
>>>>> to run an external command via popen, such as upsampling with sox). 
>>>>> I got stuck in trying to obtain these parameters in 
>>>>> pcm_file.c:_snd_pcm_file_open(). Is it actually possible or the 
>>>>> information is not available at the time of opening the file (and 
>>>>> the whole patch is thus nonsense)?
>>>>>
>>>>> Thanks a lot for help.
>>>>>
>>>> I am now opening the output file in 
>>>> pcm_file.c:snd_pcm_file_write_bytes.
>>>> Surprisingly it seems to work fine. Could such hack be accepted as a
>>>> patch to the plugin (if coded properly)? Is there a better place to 
>>>> open the file?
>>>
>>> The file should be opened in the hw_params callback (all PCM 
>>> parameters are known in this time). Also, extending filename with PCM 
>>> parameters should be optional (configurable). But the idea looks nice.
>>>
>>>                         Jaroslav
>>
> 
> Hello,
> 
> please find enclosed a patch for the file plugin. The
> checkpatch.pl script throws 5 bogus errors in doxygen comments.
> 
> Signed-off-by: Pavel Hofman <pavel.hofman@insite.cz>
> 
> * added support for including pcm stream params in the output filename
> * added support for piping the stream to a shell command if the filename
> string starts with a pipe char
> 
> Thanks a lot,
> 
> Pavel.

Hi,

Please let me know if there some areas to work on before the patch can
be accepted for merge.

Thanks a lot,

Pavel.
