From: Tim Goetze <tim@quitte.de>
Subject: Re: Why do I get broken pipe on write to a pcm in state
 PREPARED?
Date: Wed, 11 Sep 2002 23:52:27 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.21.0209112346580.598-100000@summer.quitte>
References: <200209111904.g8BJ49005923@d1o87.telia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200209111904.g8BJ49005923@d1o87.telia.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Anders Torger <torger@ludd.luth.se>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Anders Torger wrote:

>
>On Wednesday 11 September 2002 20.48, you wrote:
>> On Wed, 11 Sep 2002, Anders Torger wrote:
>> > I use a RME9652 hammerfall with two periods (the hardware is that
>> > way).
>> >
>> > I watch a file descriptor associated to the output with select(),
>> > when it gets ready for writing, I write data to the pcm with
>> > snd_pcm_writen(). In the beginning, the state of the pcm is
>> > PREPARED.
>> >
>> > What I would expect then, is that the file descriptor is ready for
>> > writing until the two periods has been filled with data, and then
>> > select will block (output buffers full, sound card not running).
>> > But instead, when the two periods is filled with data, select()
>> > still returns and says that the file descriptor is ready for
>> > writing, but when calling snd_pcm_writen(), it returns -EPIPE. The
>> > pcm state is still PREPARED.
>> >
>> > What is wrong? Is it me (probably), or is it alsa?
>>
>> You should also check for POLLERR. I'm not sure, that it's necessary
>> to return POLLOUT together with POLLERR in that case. Anyway,
>> application should check for POLLERR at first and then write data.
>
>I'm sorry, I don't understand, what would be the error in the above
>case? I just want to watch the file descriptor for writing, and expect
>that it will be triggered when there is available space in the output
>buffer to write to, or, if there is an error, for example broken pipe.
>But how could it be broken pipe if the pcm is in state PREPARED? It has
>never been put into RUNNING.
>
>The problem here is that the output buffer is full, the pcm is not
>RUNNING, but the file descriptor gets triggered anyway. When can that
>happen?

we had a hauntingly similar discussion about this a few months ago,
maybe a year. iirc everybody considered the pcm behaviour broken,
except for the alsa coders. 

seeing that you come to the same conclusion makes me again vote 
for changing this behaviour to 'poll/select blocks until running'.

tim



-------------------------------------------------------
In remembrance
www.osdn.com/911/
