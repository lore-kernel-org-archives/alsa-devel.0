From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [bug report] soundwire: Add IO transfer
Date: Mon, 8 Jan 2018 09:07:22 +0530
Message-ID: <20180108033722.GR18649@localhost>
References: <20180105134705.tgpqwx2vz7x4ja3f@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id A34B226717C
 for <alsa-devel@alsa-project.org>; Mon,  8 Jan 2018 04:33:13 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20180105134705.tgpqwx2vz7x4ja3f@mwanda>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: alsa-devel@alsa-project.org, Shreyas NC <shreyas.nc@intel.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 05, 2018 at 04:47:05PM +0300, Dan Carpenter wrote:
> Hello Vinod Koul,
> 
> The patch 9d715fa005eb: "soundwire: Add IO transfer" from Dec 14,
> 2017, leads to the following static checker warning:
> 
> 	drivers/soundwire/bus.c:309 sdw_nread()
> 	info: return a literal instead of 'ret'
> 
> drivers/soundwire/bus.c
>    297  int sdw_nread(struct sdw_slave *slave, u32 addr, size_t count, u8 *val)
>    298  {
>    299          struct sdw_msg msg;
>    300          int ret;
>    301  
>    302          ret = sdw_fill_msg(&msg, slave, addr, count,
>    303                          slave->dev_num, SDW_MSG_FLAG_READ, val);
>    304          if (ret < 0)
>    305                  return ret;
>    306  
>    307          ret = pm_runtime_get_sync(slave->bus->dev);
>    308          if (!ret)
>    309                  return ret;
> 
> Changing "return ret;" to "return 0;" is more readable, but I mostly
> am not sure this is correct.  rpm_resume() has crap comments.  It
> sometimes returns negatives, sometimes zero and sometimes one but I have
> no idea what it means...  Probably this check should be:
> 
> 		if (ret <= 0)
> 			return ret;

That's right we already have a patch for this in our internal code, will send
that out. rpm_resume can return positive values and yes that should be
documented somewhere :)

> 
> (Bugs like this is why the static checker warning exists).
> 
>    310  
>    311          ret = sdw_transfer(slave->bus, &msg);
>    312          pm_runtime_put(slave->bus->dev);
>    313  
>    314          return ret;
>    315  }
>    316  EXPORT_SYMBOL(sdw_nread);
>    317  
>    318  /**
>    319   * sdw_nwrite() - Write "n" contiguous SDW Slave registers
>    320   * @slave: SDW Slave
>    321   * @addr: Register address
>    322   * @count: length
>    323   * @val: Buffer for values to be read
>    324   */
>    325  int sdw_nwrite(struct sdw_slave *slave, u32 addr, size_t count, u8 *val)
>    326  {
>    327          struct sdw_msg msg;
>    328          int ret;
>    329  
>    330          ret = sdw_fill_msg(&msg, slave, addr, count,
>    331                          slave->dev_num, SDW_MSG_FLAG_WRITE, val);
>    332          if (ret < 0)
>    333                  return ret;
>    334  
>    335          ret = pm_runtime_get_sync(slave->bus->dev);
>    336          if (!ret)
>    337                  return ret;
> 
> Same static checker warning here.
> 
>    338  
>    339          ret = sdw_transfer(slave->bus, &msg);
>    340          pm_runtime_put(slave->bus->dev);
> 
> regards,
> dan carpenter

-- 
~Vinod
