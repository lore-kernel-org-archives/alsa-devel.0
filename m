From: "philicorda" <philicorda@ntlworld.com>
Subject: Re: Problem with echoaudio driver.
Date: Sat, 5 Apr 2003 16:15:24 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <01fe01c2fb86$2eb3a5f0$0600a8c0@silverbox>
References: <012301c2fb7b$bc142060$0600a8c0@silverbox> <3E8EEBC3.7010105@yahoo.es>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alfonso_acosta_mail@yahoo.es, Alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Subject: Re: [Alsa-devel] Problem with echoaudio driver.


> philicorda wrote:
> > Hi. I have got this compiled and installed now, but get the following
error
> > when I try to load the driver...
> >
> > root@atlantic kernel # modprobe echoaudio
> > modprobe: Too deep recursion in module dependencies!
> > modprobe: Circular dependency? OsSupportLinux CEchoGals_info
> > CEchoGals_transport echoaudio
> > Aborted
>
> What compiler are you using, gcc-3.2? I had problems with gcc-3.2 but
> everything when fine with gcc-2.95

I am using gcc-3.2.1-r6. I would use gcc-2.95, but I'm not sure how to
install it without breaking everything on my gentoo box.

I got an email from Giuliano saying the driver should compile anyway, though
he said nothing about it working. :) He wrote that there are internal c++
symbols that cause a lot of problems, and the OsSupportLinux.cpp has some
workarounds for 2.95, so I guess I'll mess around with that and see if I can
get it happy with 3.2.1.

I get the feeling that this problem may be unrelated though, as it's
aborting before the driver is loaded.
I wonder.. Are these dependencies held in modules.dep, and will editing them
sort it out, or is the problem elsewhere?



-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
