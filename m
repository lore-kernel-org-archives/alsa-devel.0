From: Mathieu Dube <mdube@8d.com>
Subject: Re: mixer and group
Date: Mon, 18 Mar 2002 16:20:05 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <02031816200502.10843@mdube.usine.8D.com>
References: <02031814141301.10843@mdube.usine.8D.com>
Reply-To: mdube@8d.com
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
In-Reply-To: <02031814141301.10843@mdube.usine.8D.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Actually nevermind,
		I figured it out by looking at the struct definitions, if anyone is 
interested here's how I did it:
	copied "Master" to group.gid.name and put group.gid.index to 0. 

One could also use PCM or any other group...

Later
-Mat

On Monday 18 March 2002 14:14, Mathieu Dube wrote:
> Hi,
> 	I dont know if anybody ever had that problem. When I open the mixer all
> seems well and there is no error.
> 	But when I try to read the group it says "No such device or address". Is
> it talking about the mixer? and if so why is snd_mixer_open not returning
> an error?
>
> Thanks
>
> -Mat

-- 
Mathieu Dube -- mdube@8d.com
8D Technologies Inc.
http://www.8d.com

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
