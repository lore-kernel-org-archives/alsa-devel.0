From: Caleb Crome <alsa@crome.org>
Subject: Re: How do create a dummy device for recording audio?
 Does it exist already?
Date: Fri, 23 Apr 2004 14:00:52 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40898404.5040501@crome.org>
References: <Pine.HPX.4.33n.0404231752570.1891-100000@studcom.urz.uni-halle.de> <4089663E.4000200@crome.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <4089663E.4000200@crome.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Caleb Crome <caleb@crome.org>
Cc: Clemens Ladisch <clemens@ladisch.de>, Caleb Crome <alsa@crome.org>, ALSA Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Caleb Crome wrote:

> Alright, I did what you suggested, and real player comes up and 
> connects to the dummy sound card (I had to do a modprobe snd-pcm-oss 
> and snd-mixer-oss).   However, I don't get a file called 
> /tmp/file.raw.  Is there any way to check how the data is routed? 
> Do I have to do anything to make .asoundrc get reread?
>
>
> Thanks again,
>   -Caleb
>
> Clemens Ladisch wrote:
>
>> Caleb Crome wrote:
>>  
>>
>>> Arek Korbik wrote:
>>>   
>>>
>>>> pcm.file {
>>>>   type file
>>>>   slave {
>>>>       pcm "hw:0,0"
>>>>   }
>>>>   file "/tmp/file.raw"
>>>> }
>>>>     
>>>
>>> what do I do with that bit of configuration data?  I found the
>>> /usr/share/alsa/alsa.conf, and there is a similar pcm.file entry
>>> in that, but it seems to take parameters.
>>>   
>>
>>
>> Put it into your ~/.asoundrc file, or into /etc/asound.conf for all
>> users.
>>
>>  
>>
>>> Since I have no sound card, how do I configure my system to use
>>> the dummy PCM driver and use the pcm.file plugin?
>>>   
>>
>>
>> "modprobe snd-dummy" should work.
>>
>>
>> HTH
>> Clemens
>>
>>
>>
>>
>> -------------------------------------------------------
>> This SF.net email is sponsored by: The Robotic Monkeys at ThinkGeek
>> For a limited time only, get FREE Ground shipping on all orders of $35
>> or more. Hurry up and shop folks, this offer expires April 30th!
>> http://www.thinkgeek.com/freeshipping/?cpg=12297
>> _______________________________________________
>> Alsa-devel mailing list
>> Alsa-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/alsa-devel
>>
>>  
>>
>
>



-------------------------------------------------------
This SF.net email is sponsored by: The Robotic Monkeys at ThinkGeek
For a limited time only, get FREE Ground shipping on all orders of $35
or more. Hurry up and shop folks, this offer expires April 30th!
http://www.thinkgeek.com/freeshipping/?cpg=12297
