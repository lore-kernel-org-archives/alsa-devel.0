From: Ed Wildgoose <lists@wildgooses.com>
Subject: Re: RME 9632 Mixer...
Date: Thu, 27 May 2004 14:30:45 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40B5ED85.7010809@wildgooses.com>
References: <40B3A472.5050206@wildgooses.com>        <Pine.HPX.4.33n.0405261744140.27472-100000@studcom.urz.uni-halle.de> <34947.217.81.127.171.1085593594.squirrel@www.undata.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <34947.217.81.127.171.1085593594.squirrel@www.undata.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Thomas Charbonnel wrote:

>>Ed Wildgoose wrote:
>>    
>>
>>>Can anyone suggest how to script the controls to default to some known
>>>values?
>>>      
>>>
>>
>This is not a standard mixer control, alsactl is of no use here.
>Ed, here's a script for 1:1 routing (hdspmixer preset 1)
>  
>

Aha, at last the penny drops... I had mucked around with this based on 
the alsa wiki instructions and hadn't got it working.  I (wrongly) seem 
to remember a post where it said this was not working anymore, and gave up.

The trick is clearly that the normal alsa sound channels start from 16, 
and outputs start from 0.

A couple of questions while I have your attention:

1) Is 32678 really 0dB?  Should it be 32767?  (I want to avoid any 
software rescaling of values where possible)
2) How can I set the output mixer values?
3) Is there any way to start hdspmixer and not load the defaults, ie so 
that I can experiment and reload hdspmixer in order to determine the 
current state of the mixer?
4) Why does the OSS emulation write to all (16)  channels when an app 
opens it in 2 channel mode?  It's very easy to do something really silly 
as a result (I got a rather nasty burning smell from my expensive 
speakers after inadvertently putting a lot of clipped signal through 
them at high power...)  Is this an OSS issue, or just the way this 
driver works?  (I don't have any other multichannel cards to compare 
against!)
5) Can you please point me to the relevant chunk of code which does the 
software mixing in the matrix mixer, also on the output channels.  I 
want to understand which if any levels can be set on the card rather 
than by dropping bits in the driver (or if you have the time, please 
feel free to enlighten me).  I'm trying to get highest quality signal, 
and wondering whether there is any kind of output based volume control 
on this card on the outside of the DAC, as opposed to just feeding it 
fewer bits.

Thanks Thomas, I really appreciate the work you have done making this 
all work.  I will try and add some notes on the alsa site for the RME 
9632 on the mixer settings

Ed W



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
