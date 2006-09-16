From: Agata Ma <ga0ata0912@yahoo.com>
Subject: Re: How to count PCM frames captured?
Date: Sat, 16 Sep 2006 01:57:41 -0700 (PDT)
Message-ID: <20060916085741.82471.qmail@web55414.mail.re4.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Clemens Ladisch wrote:
> Agata Ma wrote:
>> So, my question is: does exist an ALSA function to
count the PCM
>> frames captured and moved to buffer?
> 
> The function snd_pcm_avail_update() returns how many
frames are
> available in the device's buffer.
> 
> The function snd_pcm_readi() returns how many frames
it has copied to
> your buffer.
> 
> 
> HTH
> Clemens
> 
> 
Hi Clemens,

Thanks for your suggestion, I have wrote a simple C
code using
snd_pcm_readi() and it work..I can count the frames..

Now, a new "problem" arise...but I'm going to open a
new thread to be
more precise.

Thanks
Agata



__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
