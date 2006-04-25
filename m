From: Dave Maley <dmaley@nc.rr.com>
Subject: Re: [patch] problem w/ arecord "split interleaved
	files" feature
Date: Tue, 25 Apr 2006 17:07:35 -0400
Message-ID: <1145999255.7045.27.camel@flanders>
References: <1145943804.2670.43.camel@flanders>
	 <s5hmze9zpnn.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hmze9zpnn.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
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

Thanks for the quick response ...

> > [dave@flanders ~]$ arecord -q -t wav -f dat -d 10800 | sox -t wav -r
> > 48000 -c 2 - -t wav -r 44100 -c 2 foo.wav resample
> > 
> > 
> > It seems this new split feature doesn't work properly when writing to a
> > pipe (or at least when piping to sox).  A quick look at an strace shows
> > constant write errors, and foo.wav grows in size until the disk is full.
> 
> I guess it's rather a bug of sox.  arecord quits when the data size
> reaches to max_filesize in the case of pipe output (since obviously
> you cannot split the output).  sox should quits, too, when receiving
> EPIPE error.

Hmm, this doesn't seem to match the behavior I'm seeing.  It's very
possible I'm misunderstanding something here, but this is what I see:

Using the above arecord | sox command when the foo.wav file reaches
2000000000 in size and the split occurs it'll actually be split into
foo-01.wav and foo-02.wav, and I believe that this rename of foo.wav to
foo-01.wav is where the problem may be occurring.  I can capture strace
output at the time of the split, if it's at all helpful.

> > A quick fix for this is to set max_filesize to 2147483648.  Not sure if
> > this is a "proper" fix however I have tested it and it seems to work
> > just fine for me.  Please consider the attached patch.
> 
> Well, I'm not sure whether exactly 2GB is allowed.

If not then I'd be happy with just increasing this max_filesize to
2073600044 as that's what my 180 minute 48KHz files end up being ... 8)

Thanks again for your feedback on this.

~Dave



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
