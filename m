From: Thomas Charbonnel <thomas@undata.org>
Subject: Re: patch for h-dsp driver (fwd)
Date: 04 Mar 2003 23:06:52 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1046815611.6584.269.camel@satellite.undata.org>
References: <E18qKCl-0003tV-00@dardilly>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <E18qKCl-0003tV-00@dardilly>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

This was intended to reach the list, I guess.
On Tue, 2003-03-04 at 22:54, Paul Davis wrote:
> >[not posted to alsa-dev]
> >
> >Why didn't you keep the limit calculation. It avoids having useless
> >simple mixer entries with the multiface. (Think of users using
> >alsamixer) ?
> 
> ah, actually, that was what thomas' patch did, and i messed it up, i
> think. 
> 
> i have a new patch coming up that uses udelay instead of busy loops,
> and fixes a major issue: there is *no* firmware download for the
> hdsp9652, something i only just found out! i'll fix this issue and
> resubmit.
> 
> --p
> 



-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
