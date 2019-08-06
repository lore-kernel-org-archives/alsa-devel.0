From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 02/28] ASoC: soc-core: set
 component->debugfs_root NULL
Date: Tue, 6 Aug 2019 11:46:28 -0500
Message-ID: <d80703b2-be84-608d-0048-1f24a1fe7ebd@linux.intel.com>
References: <871rxz3x7e.wl-kuninori.morimoto.gx@renesas.com>
 <87y3072iib.wl-kuninori.morimoto.gx@renesas.com>
 <f7a47bad-b680-cbd2-2341-7be081ac4b2c@linux.intel.com>
 <20190806162258.GD4527@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7F610F800F4
 for <alsa-devel@alsa-project.org>; Tue,  6 Aug 2019 18:46:30 +0200 (CEST)
In-Reply-To: <20190806162258.GD4527@sirena.org.uk>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Mark Brown <broonie@kernel.org>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org



On 8/6/19 11:22 AM, Mark Brown wrote:
> On Tue, Aug 06, 2019 at 09:49:20AM -0500, Pierre-Louis Bossart wrote:
>>>    {
>>> +	if (!component->debugfs_root)
>>> +		return;
> 
>> that test is redundant, it's safe to call debugfs_remove_recursive() without
>> checking the argument (done internally).
> 
> It's not completely redundant...
> 
>>>    	debugfs_remove_recursive(component->debugfs_root);
>>> +	component->debugfs_root = NULL;
>>>    }
> 
> ...with this, the two in combination add protection against a double
> free.  Not 100% sure it's worth it but I queued the patch since I
> couldn't strongly convince myself it's a bad idea.

I was only referring to the first test, which will be duplicated. see below.
The second part is just fine.

/**
  * debugfs_remove_recursive - recursively removes a directory
  * @dentry: a pointer to a the dentry of the directory to be removed. 
If this
  *          parameter is NULL or an error value, nothing will be done.
  *
  * This function recursively removes a directory tree in debugfs that
  * was previously created with a call to another debugfs function
  * (like debugfs_create_file() or variants thereof.)
  *
  * This function is required to be called in order for the file to be
  * removed, no automatic cleanup of files will happen when a module is
  * removed, you are responsible here.
  */
void debugfs_remove_recursive(struct dentry *dentry)
{
	struct dentry *child, *parent;

	if (IS_ERR_OR_NULL(dentry))
		return;
